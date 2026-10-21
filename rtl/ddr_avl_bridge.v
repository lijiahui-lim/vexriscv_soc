// ddr_avl_bridge: adapts a normal 32-bit Avalon-MM slave (fabric side) to the
// UniPHY "anti-Avalon" avl port (192-bit, waitrequest_n, beginbursttransfer).
// Qsys refuses non-power-of-two slaves on the fabric, so the 48-bit-DQ EMIF
// avl port (192-bit) cannot be connected directly; the avl signals are
// exported from the qsys system and wired to this component's conduit ports
// in top.v.
//
// Fabric-side addressing: s0_address is in 4-byte words. One avl word is
// 24 bytes = 6 fabric words: avl word = addr/6, lane = addr%6.
//
// Writes: consecutive beats mapping to the same avl word are merged into one
// avl write with lane-wise byte-enables.
//
// Reads: a speculative sequential prefetch engine keeps a tagged word queue
// filled with consecutive avl words ahead of the serve position. Linear
// streams (the framebuffer reader) therefore never see EMIF read latency or
// inter-burst bubbles. A tag mismatch on the queue head (non-sequential
// access, e.g. CPU) drains the queue and re-arms speculation at the
// requested word. Any accepted write drains speculation so a later read can
// never observe pre-write data.

module ddr_avl_bridge (
    input  wire         clk,
    input  wire         reset_n,

    // ---- fabric-side Avalon-MM slave (32-bit, word addressed) ----
    input  wire [27:0]  s0_address,        // 4B word units
    input  wire [3:0]   s0_byteenable,
    input  wire         s0_read,
    input  wire         s0_write,
    input  wire [31:0]  s0_writedata,
    input  wire [6:0]   s0_burstcount,
    output wire         s0_waitrequest,
    output wire [31:0]  s0_readdata,
    output wire         s0_readdatavalid,

    // ---- avl master conduit -> exported emif_0.avl (wired in top.v) ----
    output reg  [24:0]  mavl_address,      // 24B word units
    output reg  [2:0]   mavl_burstcount,
    output reg          mavl_write,
    output reg  [191:0] mavl_writedata,
    output reg  [23:0]  mavl_byteenable,
    output reg          mavl_read,
    output reg          mavl_beginbursttransfer,
    input  wire         mavl_waitrequest_n,
    input  wire [191:0] mavl_readdata,
    input  wire         mavl_readdatavalid,

    // ---- debug snapshot (readable via the JTAG master + mailbox RAM) ----
    output wire [191:0] dbg
);

localparam S_IDLE   = 4'd0,
           S_DIVA   = 4'd1,   // DSP multiply for /6
           S_DIVB   = 4'd2,   // extract quotient, compute q*6
           S_DIVC   = 4'd3,   // lane = addr - q*6
           S_WBEAT  = 4'd4,
           S_WFLUSH = 4'd5,
           S_RD_HEAD= 4'd6,   // wait for / fetch the first word of a read burst
           S_RD_MISS= 4'd7,   // drain in-flight speculation after a tag miss
           S_RD_SERV= 4'd8;

localparam MEM_WORDS = 26'h2000000;      // 768 MB / 24 B (needs 26 bits!)

reg  [3:0]  state = S_IDLE;
reg         is_write;
reg  [6:0]  beats;          // beats remaining in the fabric burst
reg  [24:0] cur_word;       // avl word of the next fabric beat
reg  [2:0]  cur_lane;       // lane (0..5) of the next fabric beat
reg         have_beat;      // first write beat already captured
reg  [31:0] cdata;
reg  [3:0]  cbe;
reg         flush_last;     // pending word is the burst's last

// pending write word
reg         pv;
reg  [24:0] pword;
reg  [23:0] pbe;
reg  [191:0] pdata;

// speculative prefetch queue, in-order issue => in-order return.
// Data words only: the queue is strictly sequential, so the head entry's
// avl word is always (ret_word - wq_n); no tag array needed.
(* ramstyle = "logic" *) reg  [191:0] wq_data [0:31];
reg  [4:0]   wq_wp, wq_rp;
reg  [5:0]   wq_n;
reg  [5:0]   owed;          // issued reads whose data has not returned
reg          draining;      // discarding stale speculation (miss or write)
reg          spec_en;       // speculation armed (set by first read after reset/write)
reg  [24:0]  spec_word;     // next avl word to prefetch
reg          miss_v;
reg  [24:0]  miss_word;
reg  [24:0]  ret_word;      // address of the next response expected back
// reserve one slot for a read presented but not yet accepted (spec_word
// already advanced while owed has not)
wire         wq_full  = (wq_n + owed >= 6'd31);

// div/mod-6 of the captured base address via reciprocal multiply:
//   word = (addr * 0xAAAAAAAB) >> 34   (exact for addr < 2^28)
//   lane = addr - word*6
// Split over 3 cycles so every stage fits 200MHz easily.
reg  [27:0] div_a;
reg  [59:0] div_prod;
reg  [27:0] div_w6;                     // word*6
wire [25:0] div_w = div_prod[59:34];    // floor(addr/6)

// next-beat address advance
wire        lane_last = (cur_lane == 3'd5);
wire [2:0]  adv_lane  = lane_last ? 3'd0 : cur_lane + 3'd1;
// word the serve logic needs next: cur_word in S_RD_HEAD, cur_word+1 at a
// word boundary inside S_RD_SERV
wire [24:0] head_word = (state == S_RD_SERV) ? cur_word + 25'd1 : cur_word;

// accept a live write beat only when it merges into the pending word;
// while have_beat=1 the captured beat is being consumed this cycle, so a
// live beat must be held off or it would be silently dropped.
wire        beat_live   = s0_write && !have_beat;
wire        wrq_wbeat   = have_beat || (cur_word != pword);
assign      s0_waitrequest =
    (state == S_IDLE)  ? 1'b0 :
    (state == S_WBEAT) ? wrq_wbeat : 1'b1;

wire        merge_now   = (state == S_WBEAT) && (have_beat || (beat_live && !wrq_wbeat));
wire [31:0] mrg_data    = have_beat ? cdata : s0_writedata;
wire [3:0]  mrg_be      = have_beat ? cbe   : s0_byteenable;

// State decode keeps valid and data aligned for the entire service cycle.
// cur_lane advances only at the closing edge of that cycle.
reg  [191:0] serve_w;
assign s0_readdatavalid = (state == S_RD_SERV);
assign s0_readdata      = serve_w[cur_lane * 32 +: 32];

// queue bookkeeping
wire         rdv_taken = mavl_readdatavalid && (owed != 0);
wire         rdv_push  = rdv_taken && !draining;
wire         iss_acc   = mavl_read && mavl_waitrequest_n;
wire         wr_accept = s0_write && !s0_waitrequest;
wire         can_iss   = spec_en && !draining && !wq_full &&
                        (spec_word < MEM_WORDS) &&
                        (state != S_WFLUSH) && !mavl_write;

// wq_head_word tracks ret_word - wq_n (queue head word); wq_head_m1 and
// ret_m1 are registered "-1" shadows so the compare chain sees only
// cur_word vs a register, with no head_word incrementer in the path.
// (wq_head_word == cur_word+1) == (wq_head_word-1 == cur_word), and
// (cur_word+1 < ret_word) == (cur_word < ret_word-1).
// wq_head_m1 wraps on 0 (eq compare: 0x1ffffff never matches cur_word);
// ret_m1 saturates at 0 (lt compare: cur_word < 0 is false like < ret_word).
reg  [24:0] wq_head_word;
reg  [24:0] wq_head_m1;
reg  [24:0] ret_m1;
reg         arm_r;
reg  [24:0] arm_word_r;
wire         head_eq    = (state == S_RD_SERV) ? (wq_head_m1   == cur_word)
                                             : (wq_head_word == cur_word);
wire         head_lt    = (state == S_RD_SERV) ? (cur_word < ret_m1)
                                             : (cur_word < ret_word);
wire         head_match = (wq_n != 0) && head_eq;
wire         rd_need    = (state == S_RD_HEAD) ||
                        ((state == S_RD_SERV) && lane_last && (beats != 1));
wire         wq_pop     = rd_need && head_match;

// miss: queue head is the wrong word, or the needed word already returned
// and was popped/dropped (head_word < ret_word). Words still in flight
// (ret_word <= head_word < spec_word) or being issued are NOT misses.
wire         miss_req   = rd_need && !draining &&
                          ((wq_n != 0 && !head_match) ||
                           (wq_n == 0 && spec_en && head_lt));
wire         rd_wait    = rd_need && !wq_pop && !miss_req;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        wq_wp <= 0; wq_rp <= 0; wq_n <= 0; owed <= 0; serve_w <= 0;
        wq_head_word <= 0; wq_head_m1 <= 0; ret_m1 <= 0;
        draining <= 0; spec_en <= 0; miss_v <= 0; miss_word <= 0;
        spec_word <= 0; ret_word <= 0;
        arm_r <= 0; arm_word_r <= 0;
        mavl_read <= 0; mavl_address <= 0; mavl_byteenable <= 0;
        mavl_write <= 0; mavl_writedata <= 0;
        mavl_burstcount <= 3'd1; mavl_beginbursttransfer <= 1'b1;
    end else begin
        // ---- response capture ----
        if (rdv_taken) begin
            ret_word <= ret_word + 25'd1;
            ret_m1   <= ret_word;
        end
        if (rdv_push) begin
            wq_data[wq_wp] <= mavl_readdata;
            wq_wp          <= wq_wp + 1'b1;
        end
        owed <= owed + (iss_acc ? 6'd1 : 6'd0) - (rdv_taken ? 6'd1 : 6'd0);
        if (rdv_push && wq_n == 0) begin
            wq_head_word <= ret_word;
            wq_head_m1   <= ret_word - 25'd1;
        end else if (wq_pop) begin
            wq_head_word <= wq_head_word + 1'b1;
            wq_head_m1   <= wq_head_word;
        end
        if (wq_pop) begin
            serve_w <= wq_data[wq_rp];
            wq_rp   <= wq_rp + 1'b1;
        end
        wq_n <= wq_n + (rdv_push ? 6'd1 : 6'd0) - (wq_pop ? 6'd1 : 6'd0);

        // ---- drain control (miss or write) ----
        if ((state == S_IDLE) && s0_write) begin
            draining <= 1'b1;                    // kill stale prefetched data
            spec_en  <= 1'b0;
        end else if (miss_req) begin
            draining  <= 1'b1;
            miss_v    <= 1'b1;
            miss_word <= head_word;
        end else if (draining) begin
            wq_wp <= 0; wq_rp <= 0; wq_n <= 0;   // keep queue flushed
            if (owed == 0 && !mavl_read) begin   // no accepted-*or-presented* cmd
                draining <= 1'b0;
                if (miss_v) begin
                    miss_v    <= 1'b0;
                    spec_word <= miss_word;
                    ret_word  <= miss_word;
                    ret_m1    <= (miss_word != 0) ? miss_word - 25'd1 : 25'd0;
                    spec_en   <= 1'b1;
                end
            end
        end

        // ---- arm speculation at the needed word (post-reset/write) ----
        // registered one cycle: the rd_wait compare chain (cur_word vs
        // ret_m1/wq_head_m1) is too deep for afi_clk.  Deferring the arm by
        // one cycle is safe: spec_en=0 implies owed==0, so no response can
        // land in between, and rd_wait persists until the arm happens.
        arm_r <= rd_wait && !spec_en && !draining && !arm_r;
        if (rd_wait && !spec_en && !draining)
            arm_word_r <= head_word;
        if (arm_r) begin
            spec_word <= arm_word_r;
            ret_word  <= arm_word_r;
            ret_m1    <= (arm_word_r != 0) ? arm_word_r - 25'd1 : 25'd0;
            spec_en   <= 1'b1;
        end

        // ---- speculative sequential read issue ----
        // Avalon rule: once mavl_read is asserted it must be HELD until the
        // slave accepts it (waitrequest_n high).  Aborting a presented read
        // (deasserting mid-stall) desyncs our issued/owed bookkeeping from
        // what UniPHY actually consumed -> lost responses -> deadlock.
        if (mavl_read && !mavl_waitrequest_n)
            mavl_read <= 1'b1;               // hold mid-presentation
        else if (can_iss) begin
            mavl_read       <= 1'b1;
            mavl_address    <= spec_word;
            mavl_byteenable <= {24{1'b1}};
            spec_word       <= spec_word + 25'd1;
        end else
            mavl_read <= 1'b0;

        // ---- write command presentation ----
        // Never assert while a read is mid-presentation (both would be live
        // on the same avl port).
        if (state == S_WFLUSH) begin
            if (!mavl_write && !mavl_read) begin
                mavl_write      <= 1'b1;
                mavl_address    <= pword;
                mavl_writedata  <= pdata;
                mavl_byteenable <= pbe;
            end else if (mavl_write && mavl_waitrequest_n)
                mavl_write <= 1'b0;
        end else
            mavl_write <= 1'b0;

        // beginbursttransfer: single-cycle pulse coincident with a NEW
        // command being presented (same cycle mavl_read/mavl_write rise,
        // like ddr3_test); must not stay asserted across the stall window.
        if (can_iss ||
            (state == S_WFLUSH && !mavl_write && !mavl_read))
            mavl_beginbursttransfer <= 1'b1;
        else
            mavl_beginbursttransfer <= 1'b0;
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state <= S_IDLE;
        is_write <= 0; have_beat <= 0; flush_last <= 0;
        pv <= 0; pbe <= 0; pdata <= 0; pword <= 0;
        cur_word <= 0; cur_lane <= 0;
    end else begin
        case (state)
        // -------------------------------------------------------------------
        S_IDLE: begin
            if (s0_read || s0_write) begin   // wrq==0 here -> request accepted
                div_a     <= s0_address;
                beats     <= s0_burstcount;
                is_write  <= s0_write;
                if (s0_write) begin
                    cdata     <= s0_writedata;
                    cbe       <= s0_byteenable;
                    have_beat <= 1'b1;
                end
                pv    <= 1'b0;
                pdata <= 0;
                pbe   <= 0;
                state <= S_DIVA;
            end
        end
        // -------------------------------------------------------------------
        S_DIVA: begin
            div_prod <= div_a * 32'hAAAAAAAB;
            state    <= S_DIVB;
        end
        S_DIVB: begin
            div_w6 <= {div_w[24:0], 2'b0} + {div_w[24:0], 1'b0};  // *6
            state  <= S_DIVC;
        end
        S_DIVC: begin
            cur_word <= div_w[24:0];
            cur_lane <= div_a - div_w6;
            if (is_write) begin
                pword <= div_w[24:0];
                state <= S_WBEAT;
            end else
                state <= S_RD_HEAD;
        end
        // -------------------------------------------------------------------
        S_WBEAT: begin
            if (merge_now) begin
                pdata[cur_lane * 32 +: 32] <= mrg_data;
                pbe  [cur_lane * 4  +: 4 ] <= mrg_be;
                pv         <= 1'b1;
                have_beat  <= 1'b0;
                cur_word   <= lane_last ? cur_word + 25'd1 : cur_word;
                cur_lane   <= adv_lane;
                if (beats == 1) begin
                    flush_last <= 1'b1;
                    state      <= S_WFLUSH;
                end else
                    beats <= beats - 1'b1;
            end else if (cur_word != pword) begin
                // next beat belongs to a different avl word -> flush first
                // (safe even mid-word: lane byte-enables keep lanes disjoint)
                flush_last <= 1'b0;
                state      <= S_WFLUSH;
            end
        end
        // -------------------------------------------------------------------
        S_WFLUSH: begin
            if (mavl_write && mavl_waitrequest_n) begin // avl accepted
                pv    <= 1'b0;
                pdata <= 0;
                pbe   <= 0;
                if (flush_last)
                    state <= S_IDLE;
                else begin
                    pword <= cur_word;        // start pending on next word
                    state <= S_WBEAT;
                end
            end
        end
        // -------------------------------------------------------------------
        // Once a fabric read is accepted the bridge OWES the response: s0_read
        // is just the request strobe and drops right after accept; the burst
        // must run to completion and deliver every beat via readdatavalid.
        S_RD_HEAD: begin
            if (wq_pop)
                state <= S_RD_SERV;
            else if (miss_req)
                state <= S_RD_MISS;
            // else: spec arming happens in the bookkeeping block; keep waiting
        end
        // -------------------------------------------------------------------
        S_RD_MISS: begin
            if (!draining)
                state <= S_RD_HEAD;
        end
        // -------------------------------------------------------------------
        S_RD_SERV: begin
            cur_word <= lane_last ? cur_word + 25'd1 : cur_word;
            cur_lane <= adv_lane;
            if (beats == 1)
                state <= S_IDLE;
            else begin
                beats <= beats - 1'b1;
                if (miss_req)
                    state <= S_RD_MISS;
                else if (lane_last && !wq_pop)
                    state <= S_RD_HEAD;
            end
        end
        // -------------------------------------------------------------------
        default: state <= S_IDLE;
        endcase
    end
end

// event counters for debug
reg [15:0] iss_cnt;   // accepted avl read commands
reg [15:0] rdv_cnt;   // avl read responses taken
reg [15:0] pop_cnt;   // queue pops
reg [15:0] miss_cnt;  // miss/drain events
reg [4:0]  wr_cnt;    // fabric write accepts

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        iss_cnt <= 0; rdv_cnt <= 0; pop_cnt <= 0; miss_cnt <= 0;
        wr_cnt <= 0;
    end else begin
        if (iss_acc)   iss_cnt <= iss_cnt + 1'b1;
        if (rdv_taken) rdv_cnt <= rdv_cnt + 1'b1;
        if (wq_pop)    pop_cnt <= pop_cnt + 1'b1;
        if (miss_req)  miss_cnt <= miss_cnt + 1'b1;
        if (wr_accept) wr_cnt <= wr_cnt + 1'b1;
    end
end

// debug snapshot: FSM + counters + pointers (afi_clk domain)
assign dbg = {
    /* [191:176] */ iss_cnt,
    /* [175:160] */ rdv_cnt,
    /* [159:152]  */ pop_cnt[7:0],
    /* [151:144]  */ miss_cnt[7:0],
    /* [143:139]  */ wr_cnt,
    /* [138]      */ s0_read,
    /* [137]      */ s0_write,
    /* [136]      */ s0_waitrequest,
    /* [135]      */ rd_need,
    /* [134]      */ head_match,
    /* [133]      */ wq_pop,
    /* [132]      */ miss_req,
    /* [131]      */ rd_wait,
    /* [130]      */ wq_full,
    /* [129]      */ can_iss,
    /* [128]      */ iss_acc,
    /* [127:118] */ 10'd0,
    /* [117:93]  */ ret_word,               // next response expected back
    /* [92:68]   */ spec_word,              // next avl word to prefetch
    /* [67:43]   */ cur_word,               // avl word of next fabric beat
    /* [42:36]   */ beats,
    /* [35:33]   */ cur_lane,
    /* [32:30]   */ {draining, spec_en, miss_v},
    /* [29:28]   */ {mavl_waitrequest_n, mavl_readdatavalid},
    /* [27:26]   */ {mavl_read, mavl_write},
    /* [25:20]   */ owed,
    /* [19:14]   */ wq_n,
    /* [13:9]    */ wq_rp,
    /* [8:4]     */ wq_wp,
    /* [3:0]     */ state
};

endmodule
