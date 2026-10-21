// fb_reader: streams a linear 32bpp pixel buffer out of DDR3 through the
// UniPHY avl port into a dual-clock FIFO; the pixel side pops one RGB888
// pixel per pix_clk. A vsync pulse flushes the FIFO and restarts the
// reader at fb_base, so the stream is frame-aligned.
//
// Avalon-MM read master: 32-bit, word-addressed, bursts of BURST words
//   (BURST*4 bytes; must be a multiple of 24 so bursts land on 192-bit
//   avl word boundaries -- BURST=32 -> 128B (non-avl-aligned ok)).
// Avalon-MM slave (32-bit control regs):
//   0: fb_byte_base  (must be 192-byte aligned)
//   1: fb_bytes      (length in bytes, multiple of BURST*4)
//   2: ctrl          bit0 = enable (default 0)
//   3: status        bit0 = underrun sticky, bit1 = FIFO empty
//                    (write bit0=1 to clear underrun)

module fb_reader #(
    parameter AW    = 28,               // master word (4B) address width
    parameter BURST = 32,               // 32-bit words per burst (128B)
    parameter FIFOW = 10                // FIFO depth = 2^FIFOW words
)(
    input  wire             clk,
    input  wire             reset_n,

    // Avalon-MM read master (32-bit)
    output reg  [AW-1:0]    avm_address,   // in 4-byte words
    output reg              avm_read,
    output reg  [5:0]       avm_burstcount,
    input  wire             avm_waitrequest,
    input  wire [31:0]      avm_readdata,
    input  wire             avm_readdatavalid,

    // Avalon-MM control slave
    input  wire [1:0]       avs_address,
    input  wire             avs_write,
    input  wire [31:0]      avs_writedata,
    output reg  [31:0]      avs_readdata,

    // pixel domain
    input  wire             pix_clk,
    input  wire             pix_rd,      // pop one pixel (during active video)
    input  wire             pix_vsync,   // high during vsync: flush+restart
    output wire [23:0]      pix_rgb,
    output wire             pix_empty,
    output reg              pix_underrun // sticky, cleared at vsync
);

// 1280x720x4B = 3686400 B; default base byte 0x18000000
localparam [31:0] DEF_BASE  = 32'h18000000;
localparam [31:0] DEF_BYTES = 32'd3686400;

// ---------------------------------------------------------------------------
// control registers (clk domain)
// ---------------------------------------------------------------------------
reg [31:0] fb_base  = DEF_BASE;
reg [31:0] fb_bytes = DEF_BYTES;
reg        enable   = 1'b0;   // stays off until software enables it
reg        clear_underrun = 1'b0;

reg underrun_c1 = 0, underrun_c2 = 0;
reg empty_c1 = 1, empty_c2 = 1;
always @(posedge clk) begin
    underrun_c1 <= pix_underrun;
    underrun_c2 <= underrun_c1;
    empty_c1    <= pix_empty;
    empty_c2    <= empty_c1;
end

always @(posedge clk) begin
    if (avs_write) begin
        case (avs_address)
        2'd0: fb_base  <= avs_writedata;
        2'd1: fb_bytes <= avs_writedata;
        2'd2: enable   <= avs_writedata[0];
        2'd3: if (avs_writedata[0])
                  clear_underrun <= ~clear_underrun;
        default: ;
        endcase
    end
    case (avs_address)
    2'd0: avs_readdata <= fb_base;
    2'd1: avs_readdata <= fb_bytes;
    2'd2: avs_readdata <= {31'd0, enable};
    default: avs_readdata <= {30'd0, empty_c2, underrun_c2};
    endcase
end

// ---------------------------------------------------------------------------
// dual-clock FIFO, 2^FIFOW x 32b (1 word = 1 pixel)
// ---------------------------------------------------------------------------
localparam DEPTH = (1 << FIFOW);

reg [31:0]    mem [0:DEPTH-1];
reg [FIFOW:0] wbin = 0, rbin = 0;
reg [FIFOW:0] wgray = 0, rgray = 0;

function [FIFOW:0] b2g(input [FIFOW:0] b); b2g = b ^ (b >> 1); endfunction
function [FIFOW:0] g2b(input [FIFOW:0] g); integer i; begin
    g2b[FIFOW] = g[FIFOW];
    for (i = FIFOW-1; i >= 0; i = i-1) g2b[i] = g2b[i+1] ^ g[i];
end endfunction

// pointer sync (2 flops each way)
reg [FIFOW:0] rgray_w1 = 0, rgray_w2 = 0;
reg [FIFOW:0] wgray_r1 = 0, wgray_r2 = 0;
always @(posedge clk)     begin rgray_w1 <= rgray; rgray_w2 <= rgray_w1; end
always @(posedge pix_clk) begin wgray_r1 <= wgray; wgray_r2 <= wgray_r1; end

wire [FIFOW:0] rbin_w  = g2b(rgray_w2);
wire [FIFOW:0] wbin_r  = g2b(wgray_r2);
wire [FIFOW:0] wused   = wbin - rbin_w;
// declared early: beats owed by the interconnect (see write side below)
reg  [10:0] inflight;
// room for another burst = free space minus beats already owed to us
wire [12:0]    occ   = {2'b0, wused} + {2'b0, inflight};
wire           wroom = (occ <= DEPTH - BURST - 4);
wire           rempty  = (rbin == wbin_r);

// ---------------------------------------------------------------------------
// vsync flush: toggle-sync the vsync pulse into clk domain
// ---------------------------------------------------------------------------
reg vsync_px = 0;
always @(posedge pix_clk) if (pix_vsync) vsync_px <= ~vsync_px;

reg [2:0] vsync_c = 0;
wire      flush   = vsync_c[2] ^ vsync_c[1];
always @(posedge clk) vsync_c <= {vsync_c[1:0], vsync_px};

reg [2:0] clear_px = 0;
wire      clear_underrun_px = clear_px[2] ^ clear_px[1];
always @(posedge pix_clk)
    clear_px <= {clear_px[1:0], clear_underrun};

// ---------------------------------------------------------------------------
// write side (clk): DDR burst reader
// ---------------------------------------------------------------------------
reg [5:0]      rcnt = 0;                       // readdata beats left in burst
reg [AW-1:0]   raddr = DEF_BASE >> 2;          // next master-word address
wire [AW-1:0] base_u = fb_base  >> 2;
wire [AW-1:0] end_u  = (fb_base + fb_bytes) >> 2;

// Beats owed to us by the interconnect (accepted burst, beats pending) plus
// a discard count for stale pre-flush frame data. A request is NEVER
// cancelled once asserted (Avalon requires holding until accepted); beats
// already in flight at flush time are counted and thrown away instead.
reg  [10:0] discard  = 0;                 // stale beats to drop
wire       accept   = avm_read && !avm_waitrequest;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        avm_read       <= 1'b0;
        avm_address    <= {AW{1'b0}};
        avm_burstcount <= BURST[5:0];
        inflight       <= 7'd0;
        discard        <= 7'd0;
        raddr          <= DEF_BASE >> 2;
        wbin           <= 0;
        wgray          <= 0;
    end else begin
        inflight <= inflight + (accept ? {5'b0, BURST[5:0]} : 11'd0)
                            - (avm_readdatavalid ? 11'd1 : 11'd0);
        if (avm_readdatavalid) begin
            if (discard != 0)
                discard <= discard - 1'b1;
            else begin
                mem[wbin[FIFOW-1:0]] <= avm_readdata;
                wbin  <= wbin + 1'b1;
                wgray <= b2g(wbin + 1'b1);
            end
        end

        if (flush) begin
            raddr <= base_u;
            wbin  <= 0;
            wgray <= 0;
            // everything still owed -- including a request accepted this
            // cycle or still pending -- is stale frame data
            discard <= inflight + (avm_read ? {5'b0, BURST[5:0]} : 11'd0)
                              - (avm_readdatavalid ? 11'd1 : 11'd0);
        end else if (accept) begin
            avm_read <= 1'b0;
            raddr    <= (raddr + BURST >= end_u) ? base_u : raddr + BURST;
        end else if (enable && !avm_read && discard == 0
                     && wroom && fb_bytes >= (BURST*4)) begin
            avm_read       <= 1'b1;
            avm_address    <= raddr;
            avm_burstcount <= BURST[5:0];
        end
    end
end

// ---------------------------------------------------------------------------
// read side (pix_clk)
// ---------------------------------------------------------------------------
always @(posedge pix_clk) begin
    if (pix_vsync) begin
        rbin  <= 0;
        rgray <= 0;
        pix_underrun <= 1'b0;
    end else if (clear_underrun_px) begin
        pix_underrun <= 1'b0;
    end else if (pix_rd && !rempty) begin
        rbin  <= rbin + 1'b1;
        rgray <= b2g(rbin + 1'b1);
    end else if (pix_rd && rempty)
        pix_underrun <= 1'b1;
end

assign pix_rgb   = rempty ? 24'h000000 : mem[rbin[FIFOW-1:0]][23:0];
assign pix_empty = rempty;

endmodule
