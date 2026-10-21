// AL156A (G-Sync module) VexRiscv SoC
//   VexRiscv RV32IMA+Sv32 (MMU) @125MHz fab_clk + 768MB DDR3L (400MHz UniPHY)
//   Peripherals (in-chip): CLINT, PLIC, APB UART/SPI/GPIO/SYSID
//   720p HDMI driven from a DDR3 framebuffer (fb_reader + video timing + TMDS)
//   JTAG debug: jtagm -> DDR via avlbr.s0, jtagm2 -> status mailbox

module top (
    input  wire        i_sys_clk,        // T4 40MHz board clock

    input  wire        oct_rzqin,        // AF4 240R OCT calibration

    // DDR3 memory interface
    output wire [13:0] mem_a,
    output wire [2:0]  mem_ba,
    output wire [0:0]  mem_ck,
    output wire [0:0]  mem_ck_n,
    output wire [0:0]  mem_cke,
    output wire [0:0]  mem_cs_n,
    output wire [5:0]  mem_dm,
    output wire [0:0]  mem_ras_n,
    output wire [0:0]  mem_cas_n,
    output wire [0:0]  mem_we_n,
    output wire        mem_reset_n,
    inout  wire [47:0] mem_dq,
    inout  wire [5:0]  mem_dqs,
    inout  wire [5:0]  mem_dqs_n,
    output wire [0:0]  mem_odt,

    // core board LEDs
    output wire        led_g,            // A27
    output wire        led_r,            // A26

    // carrier board
    input  wire [3:0]  i_key,
    output wire [3:0]  o_led,
    input  wire        i_uart_rx,
    output wire        o_uart_tx,
    output wire        o_sd_ncs,
    output wire        o_sd_mosi,
    output wire        o_sd_dclk,
    input  wire        i_sd_miso,
    output wire        o_hdmi_clk_p,
    output wire        o_hdmi_clk_n,
    output wire [2:0]  o_hdmi_d_p,
    output wire [2:0]  o_hdmi_d_n,
    output wire [33:0] o_exter_io1,
    output wire [33:0] o_exter_io2
);

// ---------------------------------------------------------------------------
// power-on reset + key0 as manual reset
// ---------------------------------------------------------------------------
reg  [17:0] por_cnt = 18'd0;
wire por_n = por_cnt[17];
always @(posedge i_sys_clk) begin
    if (!por_n)
        por_cnt <= por_cnt + 18'd1;
end

wire global_reset_n = por_n & i_key[0];

// ---------------------------------------------------------------------------
// video PLL: 40MHz -> 75MHz pixel + 375MHz serial + 125MHz fabric
// ---------------------------------------------------------------------------
wire px_clk, x5_clk, fab_clk, pll_locked;

vidpll u_vidpll (
    .refclk_clk     (i_sys_clk),
    .reset_reset    (~por_n),
    .px_clk_clk     (px_clk),
    .x5_clk_clk     (x5_clk),
    .fab_clk_clk    (fab_clk),
    .locked_export  (pll_locked)
);

// ---------------------------------------------------------------------------
// EMIF system (emifsys): UniPHY + soft-reset bridge + JTAG masters + mailbox
// ---------------------------------------------------------------------------
wire        afi_clk;
wire        afi_reset_n;
wire        local_init_done, local_cal_success, local_cal_fail;

wire [24:0]  avl_address;
wire [2:0]   avl_burstcount;
wire         avl_write, avl_read, avl_beginbursttransfer;
wire [191:0] avl_writedata;
wire [23:0]  avl_byteenable;
wire         avl_waitrequest_n;
wire [191:0] avl_readdata;
wire         avl_readdatavalid;

// jtagm exported master (afi_clk domain)
wire [31:0]  jtag_avl_address;
wire         jtag_avl_read, jtag_avl_write;
wire [31:0]  jtag_avl_writedata;
wire [3:0]   jtag_avl_byteenable;
wire         jtag_avl_waitrequest;
wire [31:0]  jtag_avl_readdata;
wire         jtag_avl_readdatavalid;

// status mailbox write port (dbg_ram.s2)
wire [7:0]   dbg_address;
wire [31:0]  dbg_writedata;

emifsys u_soc (
    .pll_ref_clk_clk      (i_sys_clk),
    .global_reset_reset_n (global_reset_n),
    .soft_reset_reset_n   (global_reset_n),
    .oct_rzqin            (oct_rzqin),

    .afi_clk_clk          (afi_clk),
    .afi_reset_reset_n    (afi_reset_n),

    .status_local_init_done   (local_init_done),
    .status_local_cal_success (local_cal_success),
    .status_local_cal_fail    (local_cal_fail),

    .avl_address                  (avl_address),
    .avl_burstcount               (avl_burstcount),
    .avl_write                    (avl_write),
    .avl_read                     (avl_read),
    .avl_beginbursttransfer       (avl_beginbursttransfer),
    .avl_writedata                (avl_writedata),
    .avl_byteenable               (avl_byteenable),
    .avl_waitrequest_n            (avl_waitrequest_n),
    .avl_readdata                 (avl_readdata),
    .avl_readdatavalid            (avl_readdatavalid),

    .jtag_avl_address             (jtag_avl_address),
    .jtag_avl_read                (jtag_avl_read),
    .jtag_avl_write               (jtag_avl_write),
    .jtag_avl_writedata           (jtag_avl_writedata),
    .jtag_avl_byteenable          (jtag_avl_byteenable),
    .jtag_avl_waitrequest         (jtag_avl_waitrequest),
    .jtag_avl_readdata            (jtag_avl_readdata),
    .jtag_avl_readdatavalid       (jtag_avl_readdatavalid),

    .dbg_address          (dbg_address),
    .dbg_chipselect       (1'b1),
    .dbg_clken            (1'b1),
    .dbg_write            (1'b1),
    .dbg_readdata         (),
    .dbg_writedata        (dbg_writedata),
    .dbg_byteenable       (4'hF),

    .memory_mem_a         (mem_a),
    .memory_mem_ba        (mem_ba),
    .memory_mem_ck        (mem_ck),
    .memory_mem_ck_n      (mem_ck_n),
    .memory_mem_cke       (mem_cke),
    .memory_mem_cs_n      (mem_cs_n),
    .memory_mem_dm        (mem_dm),
    .memory_mem_ras_n     (mem_ras_n),
    .memory_mem_cas_n     (mem_cas_n),
    .memory_mem_we_n      (mem_we_n),
    .memory_mem_reset_n   (mem_reset_n),
    .memory_mem_dq        (mem_dq),
    .memory_mem_dqs       (mem_dqs),
    .memory_mem_dqs_n     (mem_dqs_n),
    .memory_mem_odt       (mem_odt)
);

// ---------------------------------------------------------------------------
// fabric reset: deassert once PLL locked and EMIF calibration released
// afi_reset_n (afi_clk domain) -> synchronize into fab_clk
// ---------------------------------------------------------------------------
wire fab_rst_src = global_reset_n & pll_locked & afi_reset_n;
reg  [2:0] fab_rst_meta = 3'd0;
always @(posedge fab_clk or negedge fab_rst_src)
    if (!fab_rst_src) fab_rst_meta <= 3'd0;
    else              fab_rst_meta <= {fab_rst_meta[1:0], 1'b1};
wire fab_reset_n = fab_rst_meta[2];

// ---------------------------------------------------------------------------
// VexRiscv SoC (fab_clk 125MHz)
// ---------------------------------------------------------------------------
wire [29:0] soc_ddr_addr;
wire [7:0]  soc_ddr_bc;
wire        soc_ddr_rd, soc_ddr_wr;
wire [31:0] soc_ddr_wdata;
wire [3:0]  soc_ddr_be;
wire        soc_ddr_wrq;
wire [31:0] soc_ddr_rdata;
wire        soc_ddr_rv;

wire        fbpix_rd, fbpix_vsync, fbpix_empty, fbpix_underrun;
wire [23:0] fbpix_rgb;

wire [5:0]  led_out;
wire [31:0] ext1_out, ext2_out;
wire [127:0] soc_dbg;
wire        cpu_reset_req;

soc #(.BOOT_HEX("boot.hex")) u_vex (
    .clk                (fab_clk),
    .reset_n            (fab_reset_n),

    .ddr_address        (soc_ddr_addr),
    .ddr_burstcount     (soc_ddr_bc),
    .ddr_read           (soc_ddr_rd),
    .ddr_write          (soc_ddr_wr),
    .ddr_writedata      (soc_ddr_wdata),
    .ddr_byteenable     (soc_ddr_be),
    .ddr_waitrequest    (soc_ddr_wrq),
    .ddr_readdata       (soc_ddr_rdata),
    .ddr_readdatavalid  (soc_ddr_rv),
    .ddr_response       (2'b00),

    .pix_clk            (px_clk),
    .pix_rd             (fbpix_rd),
    .pix_vsync          (fbpix_vsync),
    .pix_rgb            (fbpix_rgb),
    .pix_empty          (fbpix_empty),
    .pix_underrun       (fbpix_underrun),

    .uart_txd           (o_uart_tx),
    .uart_rxd           (i_uart_rx),
    .leds               (led_out),
    .keys               (i_key),
    .ext1               (ext1_out),
    .ext2               (ext2_out),
    .sd_sclk            (o_sd_dclk),
    .sd_mosi            (o_sd_mosi),
    .sd_miso            (i_sd_miso),
    .sd_ncs             (o_sd_ncs),

    .jtag_tck           (1'b0),
    .jtag_tms           (1'b1),
    .jtag_tdi           (1'b1),
    .jtag_tdo           (),
    .jtag_trst_n        (1'b1),
    .cpu_reset_out      (cpu_reset_req),
    .dbg                (soc_dbg)
);

// ---------------------------------------------------------------------------
// DDR path (afi_clk domain): fab->afi cdc, jtagm mux, avlbr -> emif avl
// ---------------------------------------------------------------------------
wire [29:0] afi_addr;
wire [7:0]  afi_bc;
wire        afi_rd, afi_wr;
wire [31:0] afi_wdata;
wire [3:0]  afi_be;
wire        afi_wrq;
wire [31:0] afi_rdata;
wire        afi_rv;

avl_cdc #(.AW(30), .DW(32), .BW(8)) u_cdc (
    .m_clk            (fab_clk),
    .m_reset_n        (fab_reset_n),
    .m_address        (soc_ddr_addr),
    .m_burstcount     (soc_ddr_bc),
    .m_read           (soc_ddr_rd),
    .m_write          (soc_ddr_wr),
    .m_writedata      (soc_ddr_wdata),
    .m_byteenable     (soc_ddr_be),
    .m_waitrequest    (soc_ddr_wrq),
    .m_readdata       (soc_ddr_rdata),
    .m_readdatavalid  (soc_ddr_rv),
    .m_response       (),
    .s_clk            (afi_clk),
    .s_reset_n        (afi_reset_n),
    .s_address        (afi_addr),
    .s_burstcount     (afi_bc),
    .s_read           (afi_rd),
    .s_write          (afi_wr),
    .s_writedata      (afi_wdata),
    .s_byteenable     (afi_be),
    .s_waitrequest    (afi_wrq),
    .s_readdata       (afi_rdata),
    .s_readdatavalid  (afi_rv),
    .s_response       (2'b00)
);

// 2 masters -> avlbr.s0:  m0 = cpu fabric (via cdc), m1 = jtagm tester.
// jtagm emits byte addresses; avlbr wants 28-bit word addresses of the
// window offset: jtag byte 0x4000_00xx -> addr[29:2] already drops bit30.
wire [27:0]  m2s_addr;
wire [6:0]   m2s_bc;
wire         m2s_rd, m2s_wr;
wire [31:0]  m2s_wdata;
wire [3:0]   m2s_be;
wire         m2s_wrq;
wire [31:0]  m2s_rdata;
wire         m2s_rv;

wire [27:0]  jtag_waddr = jtag_avl_address[29:2];
wire [1:0]   afi_mux_resp = 2'b00, jtag_mux_resp;

avl_mux #(.N(2), .AW(28), .DW(32), .BW(7)) u_ddr_mux (
    .clk              (afi_clk),
    .reset_n          (afi_reset_n),
    .m_address        ({jtag_waddr, afi_addr[29:2]}),
    .m_burstcount     ({7'd1, afi_bc[6:0]}),
    .m_read           ({jtag_avl_read, afi_rd}),
    .m_write          ({jtag_avl_write, afi_wr}),
    .m_writedata      ({jtag_avl_writedata, afi_wdata}),
    .m_byteenable     ({jtag_avl_byteenable, afi_be}),
    .m_waitrequest    ({jtag_avl_waitrequest, afi_wrq}),
    .m_readdata       ({jtag_avl_readdata, afi_rdata}),
    .m_readdatavalid  ({jtag_avl_readdatavalid, afi_rv}),
    .m_response       ({jtag_mux_resp, afi_mux_resp}),
    .s_address        (m2s_addr),
    .s_burstcount     (m2s_bc),
    .s_read           (m2s_rd),
    .s_write          (m2s_wr),
    .s_writedata      (m2s_wdata),
    .s_byteenable     (m2s_be),
    .s_waitrequest    (m2s_wrq),
    .s_readdata       (m2s_rdata),
    .s_readdatavalid  (m2s_rv),
    .s_response       (2'b00)
);

wire [191:0] avlbr_dbg;

ddr_avl_bridge u_avlbr (
    .clk                      (afi_clk),
    .reset_n                  (afi_reset_n),
    .s0_address               (m2s_addr),
    .s0_byteenable            (m2s_be),
    .s0_read                  (m2s_rd),
    .s0_write                 (m2s_wr),
    .s0_writedata             (m2s_wdata),
    .s0_burstcount            (m2s_bc),
    .s0_waitrequest           (m2s_wrq),
    .s0_readdata              (m2s_rdata),
    .s0_readdatavalid         (m2s_rv),
    .mavl_address             (avl_address),
    .mavl_burstcount          (avl_burstcount),
    .mavl_write               (avl_write),
    .mavl_writedata           (avl_writedata),
    .mavl_byteenable          (avl_byteenable),
    .mavl_read                (avl_read),
    .mavl_beginbursttransfer  (avl_beginbursttransfer),
    .mavl_waitrequest_n       (avl_waitrequest_n),
    .mavl_readdata            (avl_readdata),
    .mavl_readdatavalid       (avl_readdatavalid),
    .dbg                      (avlbr_dbg)
);

// ---------------------------------------------------------------------------
// video timing + TMDS out (pixel clock domain)
// ---------------------------------------------------------------------------
wire        vid_rst_n;
reg  [1:0]  pll_meta = 2'd0;
always @(posedge px_clk) pll_meta <= {pll_meta[0], pll_locked};
assign vid_rst_n = por_n & pll_meta[1];

wire        hs, vs, de;
wire [23:0] vid_rgb;

fb_video u_vid (
    .pixel_clk  (px_clk),
    .rst_n      (vid_rst_n),
    .video_hs   (hs),
    .video_vs   (vs),
    .video_de   (de),
    .video_rgb  (vid_rgb),
    .pix_rgb    (fbpix_rgb),
    .pix_empty  (fbpix_empty),
    .pix_rd     (fbpix_rd),
    .vsync_out  (fbpix_vsync)
);

dvi_transmitter_top u_dvi (
    .pclk        (px_clk),
    .pclk_x5     (x5_clk),
    .reset_n     (vid_rst_n),
    .video_din   (vid_rgb),
    .video_hsync (hs),
    .video_vsync (vs),
    .video_de    (de),
    .tmds_clk_p  (o_hdmi_clk_p),
    .tmds_clk_n  (o_hdmi_clk_n),
    .tmds_data_p (o_hdmi_d_p),
    .tmds_data_n (o_hdmi_d_n)
);

// ---------------------------------------------------------------------------
// pin mapping
// ---------------------------------------------------------------------------
assign o_led       = led_out[3:0];
assign led_g       = led_out[4];
assign led_r       = led_out[5];
assign o_exter_io1 = {2'b00, ext1_out};
assign o_exter_io2 = {2'b00, ext2_out};

// ---------------------------------------------------------------------------
// status mailbox (afi_clk): same layout as nios2_soc for reuse of the
// System Console scripts. w0 flags, w1 heartbeat, w2..w7 avlbr dbg, w31 magic
// ---------------------------------------------------------------------------
reg [26:0] hb_cnt = 27'd0;
reg [7:0]  st_addr = 8'd0;
reg [31:0] st_data;
always @(posedge afi_clk) hb_cnt <= hb_cnt + 27'd1;

// fabric-clock heartbeat (proves fab_clk alive; free-running, ungated)
reg [26:0] fab_hb = 27'd0;
always @(posedge fab_clk) fab_hb <= fab_hb + 27'd1;

reg  [7:0]  snap_div = 8'd0;
wire        do_snap = (snap_div == 8'd0);

always @(posedge afi_clk) begin
    snap_div <= snap_div + 8'd1;
    if (do_snap)
        st_addr <= (st_addr == 8'd31) ? 8'd0 : st_addr + 8'd1;
end

always @(*) begin
    case (st_addr)
    8'd0:  st_data = {16'hD3B8, 11'd0, local_cal_fail, local_cal_success,
                      local_init_done, pll_locked, fbpix_underrun};
    8'd1:  st_data = hb_cnt;
    8'd2:  st_data = avlbr_dbg[31:0];
    8'd3:  st_data = avlbr_dbg[63:32];
    8'd4:  st_data = avlbr_dbg[95:64];
    8'd5:  st_data = avlbr_dbg[127:96];
    8'd6:  st_data = avlbr_dbg[159:128];
    8'd7:  st_data = avlbr_dbg[191:160];
    8'd8:  st_data = {5'd0, fab_hb};
    8'd9:  st_data = soc_dbg[31:0];          // {ib_rdv, ib_acc}
    8'd10: st_data = soc_dbg[63:32];         // {db_rdv, db_acc}
    8'd11: st_data = soc_dbg[95:64];         // last iBus address
    8'd12: st_data = soc_dbg[127:96];        // live cpu bus levels
    8'd13: st_data = {27'd0, cpu_reset_req, fab_reset_n,
                      afi_reset_n, pll_locked, global_reset_n};
    8'd31: st_data = 32'hC0DE0005;
    default: st_data = 32'd0;
    endcase
end

assign dbg_address   = st_addr;
assign dbg_writedata = st_data;

endmodule
