// avl_cdc: Avalon-MM clock domain crossing.
//   cmd beats: master domain -> async FIFO -> slave domain
//   rsp beats: slave readdatavalid -> async FIFO -> master domain
// Avalon read responses have no backpressure; the rsp FIFO must be deep
// enough for all outstanding read beats.
//
// Packed cmd word: {address, burstcount, read, write, writedata, byteenable}
module avl_cdc #(
    parameter AW = 32,
    parameter DW = 32,
    parameter BW = 8,
    parameter CFIFO_AW = 4,                    // 16 cmd entries
    parameter RFIFO_AW = 6                     // 64 rsp entries
)(
    input  wire            m_clk,
    input  wire            m_reset_n,
    input  wire [AW-1:0]   m_address,
    input  wire [BW-1:0]   m_burstcount,
    input  wire            m_read,
    input  wire            m_write,
    input  wire [DW-1:0]   m_writedata,
    input  wire [DW/8-1:0] m_byteenable,
    output wire            m_waitrequest,
    output wire [DW-1:0]   m_readdata,
    output wire            m_readdatavalid,
    output wire [1:0]      m_response,

    input  wire            s_clk,
    input  wire            s_reset_n,
    output wire [AW-1:0]   s_address,
    output wire [BW-1:0]   s_burstcount,
    output wire            s_read,
    output wire            s_write,
    output wire [DW-1:0]   s_writedata,
    output wire [DW/8-1:0] s_byteenable,
    input  wire            s_waitrequest,
    input  wire [DW-1:0]   s_readdata,
    input  wire            s_readdatavalid,
    input  wire [1:0]      s_response
);

localparam BEW = DW/8;
localparam CW  = AW + BW + 2 + DW + BEW;
localparam RD_BIT = BEW + DW + 1;              // m_read position
localparam WR_BIT = BEW + DW;                  // m_write position

// ---------------- cmd FIFO (m -> s) ----------------
wire          cf_full, cf_empty;
wire [CW-1:0] cf_rdata;
wire          cf_rd;

avl_afifo #(.W(CW), .AW(CFIFO_AW)) u_cfifo (
    .wclk(m_clk), .wreset_n(m_reset_n),
    .wpush((m_read || m_write) && !m_waitrequest),
    .wdata({m_address, m_burstcount, m_read, m_write,
            m_writedata, m_byteenable}),
    .wfull(cf_full),
    .rclk(s_clk), .rreset_n(s_reset_n),
    .rpop(cf_rd), .rdata(cf_rdata), .rempty(cf_empty)
);

assign m_waitrequest = cf_full;

assign s_address    = cf_rdata[CW-1 -: AW];
assign s_burstcount = cf_rdata[CW-AW-1 -: BW];
assign s_read       = !cf_empty && cf_rdata[RD_BIT];
assign s_write      = !cf_empty && cf_rdata[WR_BIT];
assign s_writedata  = cf_rdata[BEW +: DW];
assign s_byteenable = cf_rdata[BEW-1:0];
assign cf_rd = (s_read || s_write) && !s_waitrequest;

// ---------------- rsp FIFO (s -> m) ----------------
wire          rf_full, rf_empty;
wire [DW+1:0] rf_rdata;

avl_afifo #(.W(DW+2), .AW(RFIFO_AW)) u_rfifo (
    .wclk(s_clk), .wreset_n(s_reset_n),
    .wpush(s_readdatavalid && !rf_full),
    .wdata({s_response, s_readdata}),
    .wfull(rf_full),
    .rclk(m_clk), .rreset_n(m_reset_n),
    .rpop(m_readdatavalid), .rdata(rf_rdata), .rempty(rf_empty)
);

assign m_readdatavalid = !rf_empty;
assign {m_response, m_readdata} = rf_rdata;

// if this ever fires, the rsp fifo was undersized -- raise RFIFO_AW
// synthesis translate_off
always @(posedge s_clk)
    if (rf_full && s_readdatavalid)
        $display("%t ERROR: avl_cdc rsp fifo overflow", $time);
// synthesis translate_on

endmodule


// avl_afifo: standard gray-code asynchronous FIFO.
// FWFT-style read port: rdata is valid whenever !rempty.
module avl_afifo #(
    parameter W  = 32,
    parameter AW = 4
)(
    input  wire         wclk,
    input  wire         wreset_n,
    input  wire         wpush,
    input  wire [W-1:0] wdata,
    output reg          wfull,

    input  wire         rclk,
    input  wire         rreset_n,
    input  wire         rpop,
    output wire [W-1:0] rdata,
    output wire         rempty
);
localparam DEPTH = 1 << AW;

(* ramstyle = "MLAB" *) reg [W-1:0] mem [0:DEPTH-1];

reg [AW:0] wptr = 0, rptr = 0;
reg [AW:0] wptr_g = 0, rptr_g = 0;
reg [AW:0] rq2_wptr = 0, wq2_rptr = 0;

function [AW:0] bin2g(input [AW:0] b);
    bin2g = (b >> 1) ^ b;
endfunction

// ---- write side ----
wire [AW:0] wptr_n   = wptr + ((wpush && !wfull) ? 1'b1 : 1'b0);
wire [AW:0] wptr_g_n = bin2g(wptr_n);
wire       wfull_c  = (wptr_g_n == {~wq2_rptr[AW:AW-1], wq2_rptr[AW-2:0]});

always @(posedge wclk or negedge wreset_n) begin
    if (!wreset_n) begin
        wptr <= 0; wptr_g <= 0; wfull <= 0;
        wq2_rptr <= 0;
    end else begin
        wq2_rptr <= rptr_g;
        if (wpush && !wfull)
            mem[wptr[AW-1:0]] <= wdata;
        wptr   <= wptr_n;
        wptr_g <= wptr_g_n;
        wfull  <= wfull_c;
    end
end

// ---- read side: FWFT prefetch register ----
// rd_r always holds the word at the head of the fifo; consumers pop it via
// rpop. The array read (rptr -> mem -> rd_r) is a same-clock path instead
// of a combinational rptr -> mem -> consumer chain, which is required to
// meet timing when rclk is fast (200 MHz afi_clk).
// arr_empty mirrors the classic "fifo array empty" flag; rempty output
// means "no prefetched word at the output".
reg  [W-1:0] rd_r;
reg          rd_v;
reg          arr_empty;

wire consume  = rpop && rd_v;
wire refill   = !arr_empty && (!rd_v || consume);

wire [AW:0] rptr_n   = rptr + (refill ? 1'b1 : 1'b0);
wire [AW:0] rptr_g_n = bin2g(rptr_n);

assign rdata  = rd_r;
assign rempty = !rd_v;

always @(posedge rclk or negedge rreset_n) begin
    if (!rreset_n) begin
        rptr <= 0; rptr_g <= 0; arr_empty <= 1;
        rd_v <= 0; rd_r <= 0;
        rq2_wptr <= 0;
    end else begin
        rq2_wptr <= wptr_g;
        rptr     <= rptr_n;
        rptr_g   <= rptr_g_n;
        arr_empty<= (rptr_g_n == rq2_wptr);
        if (refill) begin
            rd_r <= mem[rptr[AW-1:0]];
            rd_v <= 1'b1;
        end else if (consume) begin
            rd_v <= 1'b0;
        end
    end
end

endmodule
