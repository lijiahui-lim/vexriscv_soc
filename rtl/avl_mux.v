// avl_mux: N Avalon-MM masters -> 1 slave, with per-burst grant locking.
//
// Avalon burst semantics:
//   - a read burst is ONE accepted request beat (read + burstcount=N);
//     the slave returns N readdatavalid beats later.
//   - a write burst is burstcount accepted beats (first beat carries
//     address+burstcount, all beats carry writedata).
// So the grant is only locked for write bursts (bc>1). Read responses
// are routed back via a FIFO of {mid, beat count}.
module avl_mux #(
    parameter N  = 3,
    parameter AW = 32,
    parameter DW = 32,
    parameter BW = 8,
    parameter SW = (N <= 1) ? 1 : $clog2(N),
    parameter RFIFO_AW = 5                     // 32 read bursts outstanding
)(
    input  wire              clk,
    input  wire              reset_n,

    // N master ports (packed)
    input  wire [N*AW-1:0]   m_address,
    input  wire [N*BW-1:0]   m_burstcount,
    input  wire [N-1:0]      m_read,
    input  wire [N-1:0]      m_write,
    input  wire [N*DW-1:0]   m_writedata,
    input  wire [N*DW/8-1:0] m_byteenable,
    output wire [N-1:0]      m_waitrequest,
    output wire [N*DW-1:0]   m_readdata,
    output wire [N-1:0]      m_readdatavalid,
    output wire [N*2-1:0]    m_response,

    // slave port
    output wire [AW-1:0]     s_address,
    output wire [BW-1:0]     s_burstcount,
    output wire              s_read,
    output wire              s_write,
    output wire [DW-1:0]     s_writedata,
    output wire [DW/8-1:0]   s_byteenable,
    input  wire              s_waitrequest,
    input  wire [DW-1:0]     s_readdata,
    input  wire              s_readdatavalid,
    input  wire [1:0]        s_response
);

genvar gi;
wire [N-1:0] req = m_read | m_write;

// ---- grant (locked only across write-burst beats) --------------------
reg  [SW-1:0] grant    = {SW{1'b0}};
reg           locked   = 1'b0;
reg  [BW-1:0] beats    = {BW{1'b0}};
reg  [N-1:0]  rr_mask  = {N{1'b1}};         // rotating priority mask

wire [N-1:0] req_m = req & rr_mask;
wire [N-1:0] cand  = (|req_m) ? req_m : req;

integer ci;
reg [SW-1:0] cand_id;
always @(*) begin
    cand_id = {SW{1'b0}};
    for (ci = N-1; ci >= 0; ci = ci - 1)
        if (cand[ci]) cand_id = ci[SW-1:0];
end

wire [SW-1:0] cur       = locked ? grant : cand_id;
wire          cur_req   = req[cur];
wire          cur_is_rd = locked ? m_read [grant] : m_read [cand_id];
wire          cur_is_wr = locked ? m_write[grant] : m_write[cand_id];
wire [BW-1:0] cur_bc    = m_burstcount[cur*BW +: BW];

wire m_accept    = cur_req && !s_waitrequest;
wire m_accept_rd = m_accept && cur_is_rd;
wire m_accept_wr = m_accept && cur_is_wr;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        locked <= 1'b0;
        grant  <= {SW{1'b0}};
        beats  <= {BW{1'b0}};
        rr_mask <= {N{1'b1}};
    end else if (m_accept) begin
        if (!locked) begin
            // write bursts lock the grant; single beats & reads don't
            if (cur_is_wr && (cur_bc > {{BW-1{1'b0}},1'b1})) begin
                locked <= 1'b1;
                grant  <= cur;
                beats  <= cur_bc - 1'b1;
            end else begin
                rr_mask <= {N{1'b1}} << (cur + 1'b1);
            end
        end else begin
            if (beats <= {{BW-1{1'b0}},1'b1}) begin
                locked <= 1'b0;
                rr_mask <= {N{1'b1}} << (grant + 1'b1);
            end else
                beats <= beats - 1'b1;
        end
    end
end

// ---- forward ----------------------------------------------------------
assign s_address    = m_address   [cur*AW +: AW];
assign s_burstcount = cur_bc;
assign s_writedata  = m_writedata [cur*DW +: DW];
assign s_byteenable = m_byteenable[cur*DW/8 +: DW/8];
assign s_read       = cur_req && cur_is_rd;
assign s_write      = cur_req && cur_is_wr;

generate
for (gi = 0; gi < N; gi = gi + 1) begin : g_wr
    assign m_waitrequest[gi] = (cur != gi[SW-1:0]) || !cur_req ? 1'b1 :
                               s_waitrequest;
end
endgenerate

// ---- read response routing (fifo of {mid,beatcount}) -----------------
reg [SW-1:0] rf_mid [0:(1<<RFIFO_AW)-1];
reg [BW-1:0] rf_bc  [0:(1<<RFIFO_AW)-1];
reg [RFIFO_AW:0] rwp = 0, rrp = 0;
reg [BW-1:0]   rsp_left = 0;
reg            rsp_busy = 0;                 // a fifo entry is being served

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        rwp <= 0; rrp <= 0; rsp_left <= 0; rsp_busy <= 0;
    end else begin
        if (m_accept_rd) begin
            rf_mid[rwp[RFIFO_AW-1:0]] <= cur;
            rf_bc [rwp[RFIFO_AW-1:0]] <= cur_bc;
            rwp <= rwp + 1'b1;
            if (!rsp_busy && !s_readdatavalid) begin
                rsp_busy <= 1'b1;
                rsp_left <= cur_bc;
            end
        end
        if (s_readdatavalid) begin
            if (!rsp_busy) begin
                // rdv for a read accepted this same cycle: count it as
                // beat 1 of that entry
                if (m_accept_rd) begin
                    rsp_busy <= 1'b1;
                    rsp_left <= cur_bc - 1'b1;
                    if (cur_bc <= 1)
                        rrp <= rrp + 1'b1;
                end
            end else begin
                rsp_left <= rsp_left - 1'b1;
                if (rsp_left <= 1) begin
                    rsp_busy <= 0;
                    rrp      <= rrp + 1'b1;
                    // preload the next queued entry if present
                    if (rwp != rrp + 1'b1) begin
                        rsp_busy <= 1'b1;
                        rsp_left <= rf_bc[rrp[RFIFO_AW-1:0] + 1'b1];
                    end
                end
            end
        end
    end
end

wire [SW-1:0] rsp_mid = rsp_busy ? rf_mid[rrp[RFIFO_AW-1:0]] : cur;
generate
for (gi = 0; gi < N; gi = gi + 1) begin : g_rsp
    assign m_readdata     [gi*DW +: DW] = s_readdata;
    assign m_response     [gi*2 +: 2]   = s_response;
    assign m_readdatavalid[gi]          = s_readdatavalid &&
                                          (rsp_mid == gi[SW-1:0]);
end
endgenerate

endmodule
