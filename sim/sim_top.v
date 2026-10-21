// sim_top: full SoC + DDR chain under verilator.
//   fab_clk 125MHz -> soc -> avl_cdc -> afi_clk 200MHz -> avlbr -> sim_emif
// C++ harness drives clk edges and samples uart_txd.
module sim_top #(
    parameter BOOT_HEX = "",
    parameter DDR_WORDS = 65536,
    parameter DDR_HEX = ""
)(
    input  wire clk,          // fab clock (125 MHz nominal)
    input  wire afi_clk,      // emif clock (200 MHz nominal)
    input  wire reset_n,

    output wire uart_txd,
    input  wire uart_rxd,

    output wire [5:0] leds,
    input  wire [3:0] keys,

    output wire [9:0] tmds0,
    output wire [9:0] tmds1,
    output wire [9:0] tmds2,
    output wire [127:0] dbg
);

// soc ddr master port (fab domain, window-relative byte addr)
wire [29:0] soc_ddr_addr;
wire [7:0]  soc_ddr_bc;
wire        soc_ddr_rd, soc_ddr_wr;
wire [31:0] soc_ddr_wdata;
wire [3:0]  soc_ddr_be;
wire        soc_ddr_wrq;
wire [31:0] soc_ddr_rdata;
wire        soc_ddr_rv;
wire [1:0]  soc_ddr_resp = 2'b00;

soc #(.BOOT_HEX(BOOT_HEX)) u_soc (
    .clk(clk), .reset_n(reset_n),
    .ddr_address   (soc_ddr_addr),
    .ddr_burstcount(soc_ddr_bc),
    .ddr_read      (soc_ddr_rd),
    .ddr_write     (soc_ddr_wr),
    .ddr_writedata (soc_ddr_wdata),
    .ddr_byteenable(soc_ddr_be),
    .ddr_waitrequest(soc_ddr_wrq),
    .ddr_readdata  (soc_ddr_rdata),
    .ddr_readdatavalid(soc_ddr_rv),
    .ddr_response  (soc_ddr_resp),
    .pix_clk(clk), .pix_reset(~reset_n),
    .tmds0(tmds0), .tmds1(tmds1), .tmds2(tmds2),
    .vid_status(),
    .uart_txd(uart_txd), .uart_rxd(uart_rxd),
    .leds(leds), .keys(keys),
    .ext1(), .ext2(),
    .sd_sclk(), .sd_mosi(), .sd_miso(1'b1), .sd_ncs(),
    .jtag_tck(1'b0), .jtag_tms(1'b1), .jtag_tdi(1'b1),
    .jtag_tdo(), .jtag_trst_n(1'b1),
    .cpu_reset_out(),
    .dbg(dbg)
);

// ---- cdc: fab -> afi --------------------------------------------------
wire [29:0] afi_addr;
wire [7:0]  afi_bc;
wire        afi_rd, afi_wr;
wire [31:0] afi_wdata;
wire [3:0]  afi_be;
wire        afi_wrq;
wire [31:0] afi_rdata;
wire        afi_rv;
wire [1:0]  afi_resp = 2'b00;

avl_cdc #(.AW(30), .DW(32), .BW(8)) u_cdc (
    .m_clk(clk), .m_reset_n(reset_n),
    .m_address   (soc_ddr_addr), .m_burstcount(soc_ddr_bc),
    .m_read      (soc_ddr_rd),   .m_write(soc_ddr_wr),
    .m_writedata (soc_ddr_wdata),.m_byteenable(soc_ddr_be),
    .m_waitrequest(soc_ddr_wrq),
    .m_readdata  (soc_ddr_rdata),.m_readdatavalid(soc_ddr_rv),
    .m_response  (),
    .s_clk(afi_clk), .s_reset_n(reset_n),
    .s_address   (afi_addr), .s_burstcount(afi_bc),
    .s_read      (afi_rd),   .s_write(afi_wr),
    .s_writedata (afi_wdata),.s_byteenable(afi_be),
    .s_waitrequest(afi_wrq),
    .s_readdata  (afi_rdata),.s_readdatavalid(afi_rv),
    .s_response  (afi_resp)
);

// ---- avlbr + emif (afi domain) ----------------------------------------
wire [24:0]  mavl_addr;
wire [2:0]   mavl_bc;
wire         mavl_wr, mavl_rd, mavl_bbt;
wire [191:0] mavl_wdata;
wire [23:0]  mavl_be;
wire         mavl_wrqn;
wire [191:0] mavl_rdata;
wire         mavl_rv;

ddr_avl_bridge u_avlbr (
    .clk(afi_clk), .reset_n(reset_n),
    .s0_address      (afi_addr[29:2]),      // byte offset -> word
    .s0_byteenable   (afi_be),
    .s0_read         (afi_rd),
    .s0_write        (afi_wr),
    .s0_writedata    (afi_wdata),
    .s0_burstcount   (afi_bc[6:0]),
    .s0_waitrequest  (afi_wrq),
    .s0_readdata     (afi_rdata),
    .s0_readdatavalid(afi_rv),
    .mavl_address   (mavl_addr),
    .mavl_burstcount(mavl_bc),
    .mavl_write     (mavl_wr),
    .mavl_writedata (mavl_wdata),
    .mavl_byteenable(mavl_be),
    .mavl_read      (mavl_rd),
    .mavl_beginbursttransfer(mavl_bbt),
    .mavl_waitrequest_n(mavl_wrqn),
    .mavl_readdata  (mavl_rdata),
    .mavl_readdatavalid(mavl_rv),
    .dbg()
);

sim_emif #(.WORDS(DDR_WORDS), .RD_LATENCY(8), .DDR_HEX(DDR_HEX)) u_emif (
    .clk(afi_clk), .reset_n(reset_n),
    .mavl_address   (mavl_addr),
    .mavl_burstcount(mavl_bc),
    .mavl_write     (mavl_wr),
    .mavl_writedata (mavl_wdata),
    .mavl_byteenable(mavl_be),
    .mavl_read      (mavl_rd),
    .mavl_beginbursttransfer(mavl_bbt),
    .mavl_waitrequest_n(mavl_wrqn),
    .mavl_readdata  (mavl_rdata),
    .mavl_readdatavalid(mavl_rv)
);

endmodule
