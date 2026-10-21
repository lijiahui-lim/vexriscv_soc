// soc: VexRiscv (RV32IMA+Sv32) SoC fabric, single clock (fab_clk, 125MHz).
//
// Address map (byte addresses on all Avalon ports):
//   0x0000_0000-0x0000_7fff  boot_ram 32KB (i+d)
//   0x4000_0000-0x7fff_ffff  DDR window -> ddr_* master port (i+d+fb)
//   0xf000_0000-0xf000_ffff  CLINT  (axil via avl2axil)
//   0xf100_0000-0xf10f_ffff  AlvxApb peripheral window (apb via avl2apb)
//   0xf200_0000-0xf200_0fff  fb_reader csr
//   0xfc00_0000-0xfc3f_ffff  PLIC   (axil via avl2axil)
//
// ddr_* port is a window-relative BYTE-addressed Avalon master:
//   byte offset = fabric_addr - 0x4000_0000 = fabric_addr[29:0].
// Downstream (top.v) converts to the avl bridge's word units (>>2).
//
// CPU Avalon conventions: waitRequestn is ACTIVE-LOW on the cpu ports;
// the fabric uses active-high waitrequest -- inverted at the cpu edge.
// cpu reset/debugReset are active high.
module soc #(
    parameter BOOT_HEX = ""                    // $readmemh for boot_ram
)(
    input  wire        clk,
    input  wire        reset_n,

    // ---- DDR window master port (Avalon, window-relative byte addr) ----
    output wire [29:0] ddr_address,
    output wire [7:0]  ddr_burstcount,
    output wire        ddr_read,
    output wire        ddr_write,
    output wire [31:0] ddr_writedata,
    output wire [3:0]  ddr_byteenable,
    input  wire        ddr_waitrequest,
    input  wire [31:0] ddr_readdata,
    input  wire        ddr_readdatavalid,
    input  wire [1:0]  ddr_response,

    // ---- framebuffer reader pixel interface (pix_clk domain) ----
    input  wire        pix_clk,
    input  wire        pix_rd,
    input  wire        pix_vsync,
    output wire [23:0] pix_rgb,
    output wire        pix_empty,
    output wire        pix_underrun,

    // ---- peripheral pins ----
    output wire        uart_txd,
    input  wire        uart_rxd,
    output wire [5:0]  leds,
    input  wire [3:0]  keys,
    output wire [31:0] ext1,
    output wire [31:0] ext2,
    output wire        sd_sclk,
    output wire        sd_mosi,
    input  wire        sd_miso,
    output wire        sd_ncs,

    // ---- cpu jtag debug ----
    input  wire        jtag_tck,
    input  wire        jtag_tms,
    input  wire        jtag_tdi,
    output wire        jtag_tdo,
    input  wire        jtag_trst_n,      // cpu debugReset (active low in)
    output wire        cpu_reset_out,    // debug module reset request
    output wire [127:0] dbg              // cpu bus activity (fab_clk domain)
);

wire reset = ~reset_n;
wire [31:0] chip_dbg;

// ===========================================================================
// cpu complex
// ===========================================================================
wire        cpu_ibus_rd;
wire [31:0] cpu_ibus_addr;
wire [3:0]  cpu_ibus_bc;
wire        cpu_ibus_wrn;
wire [1:0]  cpu_ibus_resp;
wire        cpu_ibus_rdv;
wire [31:0] cpu_ibus_rdata;

wire        cpu_dbus_rd, cpu_dbus_wr;
wire [31:0] cpu_dbus_addr;
wire [3:0]  cpu_dbus_bc;
wire [3:0]  cpu_dbus_be;
wire [31:0] cpu_dbus_wdata;
wire        cpu_dbus_wrn;
wire [1:0]  cpu_dbus_resp;
wire        cpu_dbus_rdv;
wire [31:0] cpu_dbus_rdata;

wire        irq_uart, irq_spi, irq_key;
wire [31:0] plic_src = {29'd0, irq_key, irq_spi, irq_uart};

// clint/plic axilite (driven by avl2axil bridges)
wire [15:0] clint_awaddr;  wire clint_awvalid, clint_awready;
wire [31:0] clint_wdata;   wire [3:0] clint_wstrb;
wire        clint_wvalid, clint_wready;
wire        clint_bvalid, clint_bready;  wire [1:0] clint_bresp;
wire [15:0] clint_araddr;  wire clint_arvalid, clint_arready;
wire [31:0] clint_rdata;   wire clint_rvalid, clint_rready; wire [1:0] clint_rresp;

wire [21:0] plic_awaddr;   wire plic_awvalid, plic_awready;
wire [31:0] plic_wdata;    wire [3:0] plic_wstrb;
wire        plic_wvalid, plic_wready;
wire        plic_bvalid, plic_bready;    wire [1:0] plic_bresp;
wire [21:0] plic_araddr;   wire plic_arvalid, plic_arready;
wire [31:0] plic_rdata;    wire plic_rvalid, plic_rready;   wire [1:0] plic_rresp;

// apb3 into the chip's peripheral block (driven by avl2apb below)
wire [19:0] apb_paddr;
wire        apb_psel, apb_penable, apb_pwrite, apb_pready, apb_pslverr;
wire [31:0] apb_pwdata, apb_prdata;

AlvxChip u_chip (
    .clint_awvalid (clint_awvalid), .clint_awready(clint_awready),
    .clint_awaddr  (clint_awaddr),  .clint_awprot (3'b000),
    .clint_wvalid  (clint_wvalid),  .clint_wready (clint_wready),
    .clint_wdata   (clint_wdata),   .clint_wstrb  (clint_wstrb),
    .clint_bvalid  (clint_bvalid),  .clint_bready (clint_bready),
    .clint_bresp   (clint_bresp),
    .clint_arvalid (clint_arvalid), .clint_arready(clint_arready),
    .clint_araddr  (clint_araddr),  .clint_arprot (3'b000),
    .clint_rvalid  (clint_rvalid),  .clint_rready (clint_rready),
    .clint_rdata   (clint_rdata),   .clint_rresp  (clint_rresp),

    .plic_awvalid  (plic_awvalid),  .plic_awready (plic_awready),
    .plic_awaddr   (plic_awaddr),   .plic_awprot  (3'b000),
    .plic_wvalid   (plic_wvalid),   .plic_wready  (plic_wready),
    .plic_wdata    (plic_wdata),    .plic_wstrb   (plic_wstrb),
    .plic_bvalid   (plic_bvalid),   .plic_bready  (plic_bready),
    .plic_bresp    (plic_bresp),
    .plic_arvalid  (plic_arvalid),  .plic_arready (plic_arready),
    .plic_araddr   (plic_araddr),   .plic_arprot  (3'b000),
    .plic_rvalid   (plic_rvalid),   .plic_rready  (plic_rready),
    .plic_rdata    (plic_rdata),    .plic_rresp   (plic_rresp),
    .plicInterrupts(plic_src),

    .apb_PADDR   (apb_paddr),
    .apb_PSEL    (apb_psel),
    .apb_PENABLE (apb_penable),
    .apb_PREADY  (apb_pready),
    .apb_PWRITE  (apb_pwrite),
    .apb_PWDATA  (apb_pwdata),
    .apb_PRDATA  (apb_prdata),
    .apb_PSLVERROR(apb_pslverr),
    .uart_txd(uart_txd), .uart_rxd(uart_rxd),
    .leds(leds), .keys(keys),
    .ext1(ext1), .ext2(ext2),
    .sd_sclk(sd_sclk), .sd_mosi(sd_mosi),
    .sd_miso(sd_miso), .sd_ncs(sd_ncs),
    .irq_uart(irq_uart), .irq_spi(irq_spi), .irq_key(irq_key),

    .debug_resetOut(cpu_reset_out),

    .iBusAvalon_read         (cpu_ibus_rd),
    .iBusAvalon_waitRequestn (cpu_ibus_wrn),
    .iBusAvalon_address      (cpu_ibus_addr),
    .iBusAvalon_burstCount   (cpu_ibus_bc),
    .iBusAvalon_response     (cpu_ibus_resp),
    .iBusAvalon_readDataValid(cpu_ibus_rdv),
    .iBusAvalon_readData     (cpu_ibus_rdata),

    .dBusAvalon_read         (cpu_dbus_rd),
    .dBusAvalon_write        (cpu_dbus_wr),
    .dBusAvalon_waitRequestn (cpu_dbus_wrn),
    .dBusAvalon_address      (cpu_dbus_addr),
    .dBusAvalon_burstCount   (cpu_dbus_bc),
    .dBusAvalon_byteEnable   (cpu_dbus_be),
    .dBusAvalon_writeData    (cpu_dbus_wdata),
    .dBusAvalon_response     (cpu_dbus_resp),
    .dBusAvalon_readDataValid(cpu_dbus_rdv),
    .dBusAvalon_readData     (cpu_dbus_rdata),

    .jtag_tms (jtag_tms),
    .jtag_tdi (jtag_tdi),
    .jtag_tdo (jtag_tdo),
    .jtag_tck (jtag_tck),

    .clk        (clk),
    .reset      (reset),
    .debugReset (reset | ~jtag_trst_n),
    .cpu_dbg    (chip_dbg)
);

// ===========================================================================
// iBus demux: {ram, ddr}
// ===========================================================================
wire [1:0]   i_s_rd, i_s_rv;
wire [1:0]   i_s_wr;
wire [63:0]  i_s_addr;
wire [15:0]  i_s_bc;
wire [63:0]  i_s_wdata;
wire [7:0]   i_s_be;
wire [1:0]   i_s_wrq;
wire [63:0]  i_s_rdata;
wire [3:0]   i_s_resp;
wire         i_m_wrq, i_m_rv;
wire [31:0]  i_m_rdata;
wire [1:0]   i_m_resp;

avl_demux #(
    .N(2), .BW(8),
    .BASE({32'h4000_0000, 32'h0000_0000}),
    .MASK({32'hC000_0000, 32'hFFFF_8000})
) u_idemux (
    .clk(clk), .reset_n(reset_n),
    .m_address(cpu_ibus_addr), .m_burstcount({4'd0, cpu_ibus_bc}),
    .m_read(cpu_ibus_rd), .m_write(1'b0),
    .m_writedata(32'd0), .m_byteenable(4'hF),
    .m_waitrequest(i_m_wrq),
    .m_readdata(i_m_rdata), .m_readdatavalid(i_m_rv), .m_response(i_m_resp),
    .s_address(i_s_addr), .s_burstcount(i_s_bc),
    .s_read(i_s_rd), .s_write(i_s_wr),
    .s_writedata(i_s_wdata), .s_byteenable(i_s_be),
    .s_waitrequest(i_s_wrq), .s_readdata(i_s_rdata),
    .s_readdatavalid(i_s_rv), .s_response(i_s_resp)
);
assign cpu_ibus_wrn  = ~i_m_wrq;
assign cpu_ibus_resp = i_m_resp;
assign cpu_ibus_rdv  = i_m_rv;
assign cpu_ibus_rdata= i_m_rdata;

// ===========================================================================
// dBus demux: {ram, clint, apb, fb, plic, ddr}
// ===========================================================================
localparam DS_RAM = 0, DS_CLINT = 1, DS_APB = 2, DS_FB = 3,
           DS_PLIC = 4, DS_DDR = 5;

wire [5:0]   d_s_rd, d_s_rv, d_s_wr;
wire [191:0] d_s_addr;
wire [47:0]  d_s_bc;
wire [191:0] d_s_wdata;
wire [23:0]  d_s_be;
wire [5:0]   d_s_wrq;
wire [191:0] d_s_rdata;
wire [11:0]  d_s_resp;
wire         d_m_wrq, d_m_rv;
wire [31:0]  d_m_rdata;
wire [1:0]   d_m_resp;

avl_demux #(
    .N(6), .BW(8),
    .BASE({32'h4000_0000, 32'hFC00_0000, 32'hF200_0000,
           32'hF100_0000, 32'hF000_0000, 32'h0000_0000}),
    .MASK({32'hC000_0000, 32'hFFC0_0000, 32'hFFFF_F000,
           32'hFFF0_0000, 32'hFFFF_0000, 32'hFFFF_8000})
) u_ddemux (
    .clk(clk), .reset_n(reset_n),
    .m_address(cpu_dbus_addr), .m_burstcount({4'd0, cpu_dbus_bc}),
    .m_read(cpu_dbus_rd), .m_write(cpu_dbus_wr),
    .m_writedata(cpu_dbus_wdata), .m_byteenable(cpu_dbus_be),
    .m_waitrequest(d_m_wrq),
    .m_readdata(d_m_rdata), .m_readdatavalid(d_m_rv), .m_response(d_m_resp),
    .s_address(d_s_addr), .s_burstcount(d_s_bc),
    .s_read(d_s_rd), .s_write(d_s_wr),
    .s_writedata(d_s_wdata), .s_byteenable(d_s_be),
    .s_waitrequest(d_s_wrq), .s_readdata(d_s_rdata),
    .s_readdatavalid(d_s_rv), .s_response(d_s_resp)
);
assign cpu_dbus_wrn  = ~d_m_wrq;
assign cpu_dbus_resp = d_m_resp;
assign cpu_dbus_rdv  = d_m_rv;
assign cpu_dbus_rdata= d_m_rdata;

// ===========================================================================
// boot_ram: port A on iBus slot 0, port B on dBus slot 0
// ===========================================================================
wire [31:0] ram_a_rdata, ram_b_rdata;
wire        ram_a_rv, ram_b_rv;

boot_ram #(.WORDS(8192), .HEX(BOOT_HEX)) u_bootram (
    .clk(clk), .reset_n(reset_n),
    .a_address       (i_s_addr[31:0]),
    .a_burstcount    (i_s_bc[7:0]),
    .a_read          (i_s_rd[0]),
    .a_write         (i_s_wr[0]),
    .a_writedata     (i_s_wdata[31:0]),
    .a_byteenable    (i_s_be[3:0]),
    .a_waitrequest   (i_s_wrq[0]),
    .a_readdata      (ram_a_rdata),
    .a_readdatavalid (ram_a_rv),
    .a_response      (),
    .b_address       (d_s_addr[31:0]),
    .b_burstcount    (d_s_bc[7:0]),
    .b_read          (d_s_rd[DS_RAM]),
    .b_write         (d_s_wr[DS_RAM]),
    .b_writedata     (d_s_wdata[31:0]),
    .b_byteenable    (d_s_be[3:0]),
    .b_waitrequest   (d_s_wrq[DS_RAM]),
    .b_readdata      (ram_b_rdata),
    .b_readdatavalid (ram_b_rv),
    .b_response      ()
);
assign i_s_rdata[31:0] = ram_a_rdata;
assign i_s_rv[0]   = ram_a_rv;
assign i_s_resp[1:0] = 2'b00;
assign d_s_rdata[DS_RAM*32 +: 32] = ram_b_rdata;
assign d_s_rv[DS_RAM] = ram_b_rv;
assign d_s_resp[DS_RAM*2 +: 2] = 2'b00;

// ===========================================================================
// clint (dBus slot 1) + plic (slot 4) via avl2axil
// ===========================================================================
avl2axil #(.AW(16)) u_clint_b (
    .clk(clk), .reset_n(reset_n),
    .avl_address      (d_s_addr[DS_CLINT*32 +: 16]),
    .avl_read         (d_s_rd[DS_CLINT]),
    .avl_write        (d_s_wr[DS_CLINT]),
    .avl_writedata    (d_s_wdata[DS_CLINT*32 +: 32]),
    .avl_byteenable   (d_s_be[DS_CLINT*4 +: 4]),
    .avl_waitrequest  (d_s_wrq[DS_CLINT]),
    .avl_readdata     (d_s_rdata[DS_CLINT*32 +: 32]),
    .avl_readdatavalid(d_s_rv[DS_CLINT]),
    .avl_response     (d_s_resp[DS_CLINT*2 +: 2]),
    .axil_awaddr(clint_awaddr), .axil_awvalid(clint_awvalid),
    .axil_awready(clint_awready),
    .axil_wdata(clint_wdata), .axil_wstrb(clint_wstrb),
    .axil_wvalid(clint_wvalid), .axil_wready(clint_wready),
    .axil_bresp(clint_bresp), .axil_bvalid(clint_bvalid),
    .axil_bready(clint_bready),
    .axil_araddr(clint_araddr), .axil_arvalid(clint_arvalid),
    .axil_arready(clint_arready),
    .axil_rdata(clint_rdata), .axil_rresp(clint_rresp),
    .axil_rvalid(clint_rvalid), .axil_rready(clint_rready)
);

avl2axil #(.AW(22)) u_plic_b (
    .clk(clk), .reset_n(reset_n),
    .avl_address      (d_s_addr[DS_PLIC*32 +: 22]),
    .avl_read         (d_s_rd[DS_PLIC]),
    .avl_write        (d_s_wr[DS_PLIC]),
    .avl_writedata    (d_s_wdata[DS_PLIC*32 +: 32]),
    .avl_byteenable   (d_s_be[DS_PLIC*4 +: 4]),
    .avl_waitrequest  (d_s_wrq[DS_PLIC]),
    .avl_readdata     (d_s_rdata[DS_PLIC*32 +: 32]),
    .avl_readdatavalid(d_s_rv[DS_PLIC]),
    .avl_response     (d_s_resp[DS_PLIC*2 +: 2]),
    .axil_awaddr(plic_awaddr), .axil_awvalid(plic_awvalid),
    .axil_awready(plic_awready),
    .axil_wdata(plic_wdata), .axil_wstrb(plic_wstrb),
    .axil_wvalid(plic_wvalid), .axil_wready(plic_wready),
    .axil_bresp(plic_bresp), .axil_bvalid(plic_bvalid),
    .axil_bready(plic_bready),
    .axil_araddr(plic_araddr), .axil_arvalid(plic_arvalid),
    .axil_arready(plic_arready),
    .axil_rdata(plic_rdata), .axil_rresp(plic_rresp),
    .axil_rvalid(plic_rvalid), .axil_rready(plic_rready)
);

// ===========================================================================
// AlvxApb peripheral block (dBus slot 2) via avl2apb
// ===========================================================================
avl2apb #(.AW(20)) u_apb_b (
    .clk(clk), .reset_n(reset_n),
    .avl_address      (d_s_addr[DS_APB*32 +: 20]),
    .avl_read         (d_s_rd[DS_APB]),
    .avl_write        (d_s_wr[DS_APB]),
    .avl_writedata    (d_s_wdata[DS_APB*32 +: 32]),
    .avl_byteenable   (d_s_be[DS_APB*4 +: 4]),
    .avl_waitrequest  (d_s_wrq[DS_APB]),
    .avl_readdata     (d_s_rdata[DS_APB*32 +: 32]),
    .avl_readdatavalid(d_s_rv[DS_APB]),
    .avl_response     (d_s_resp[DS_APB*2 +: 2]),
    .apb_paddr   (apb_paddr),
    .apb_psel    (apb_psel),
    .apb_penable (apb_penable),
    .apb_pwrite  (apb_pwrite),
    .apb_pwdata  (apb_pwdata),
    .apb_prdata  (apb_prdata),
    .apb_pready  (apb_pready),
    .apb_pslverr (apb_pslverr)
);

// ===========================================================================
// fb_reader (dBus slot 3 csr; avm -> ddr arbiter)
// ===========================================================================
wire        fb_avs_rd  = d_s_rd[DS_FB];
wire        fb_avs_wr  = d_s_wr[DS_FB];
reg         fb_avs_rv;
always @(posedge clk or negedge reset_n)
    if (!reset_n) fb_avs_rv <= 1'b0;
    else          fb_avs_rv <= fb_avs_rd;

wire [27:0] fb_avm_addr;
wire        fb_avm_rd;
wire [5:0]  fb_avm_bc;
wire        fb_avm_wrq;
wire [31:0] fb_avm_rdata;
wire        fb_avm_rv;

fb_reader u_fb (
    .clk(clk), .reset_n(reset_n),
    .avm_address       (fb_avm_addr),
    .avm_read          (fb_avm_rd),
    .avm_burstcount    (fb_avm_bc),
    .avm_waitrequest   (fb_avm_wrq),
    .avm_readdata      (fb_avm_rdata),
    .avm_readdatavalid (fb_avm_rv),
    .avs_address       (d_s_addr[DS_FB*32 + 3 -: 2]),
    .avs_write         (fb_avs_wr),
    .avs_writedata     (d_s_wdata[DS_FB*32 +: 32]),
    .avs_readdata      (d_s_rdata[DS_FB*32 +: 32]),
    .pix_clk(pix_clk), .pix_rd(pix_rd), .pix_vsync(pix_vsync),
    .pix_rgb(pix_rgb), .pix_empty(pix_empty), .pix_underrun(pix_underrun)
);
assign d_s_wrq[DS_FB] = 1'b0;
assign d_s_rv[DS_FB]  = fb_avs_rv;
assign d_s_resp[DS_FB*2 +: 2] = 2'b00;

// ===========================================================================
// DDR arbiter: {ibus, dbus, fb} -> ddr_* port
// ===========================================================================
// master 0 = ibus ddr slot (i_s_* index 1)
// master 1 = dbus ddr slot (d_s_* index DS_DDR)
// master 2 = fb avm (word addr -> window-relative byte addr)
wire [31:0] dd_s_addr_full;
wire [2:0]  dd_wrq, dd_rv;
wire [95:0] dd_rdat;
wire [5:0]  dd_rsp;

avl_mux #(.N(3), .AW(32), .DW(32), .BW(8)) u_ddr_mux (
    .clk(clk), .reset_n(reset_n),
    .m_address    ({ {2'b00, fb_avm_addr, 2'b00},
                     d_s_addr[DS_DDR*32 +: 32],
                     i_s_addr[63:32]          }),
    .m_burstcount ({ {2'b00, fb_avm_bc},
                     d_s_bc[DS_DDR*8 +: 8],
                     i_s_bc[15:8]             }),
    .m_read       ({fb_avm_rd, d_s_rd[DS_DDR], i_s_rd[1]}),
    .m_write      ({1'b0, d_s_wr[DS_DDR], i_s_wr[1]}),
    .m_writedata  ({32'd0, d_s_wdata[DS_DDR*32 +: 32], 32'd0}),
    .m_byteenable ({4'hF, d_s_be[DS_DDR*4 +: 4], 4'hF}),
    .m_waitrequest(dd_wrq),
    .m_readdata   (dd_rdat),
    .m_readdatavalid(dd_rv),
    .m_response   (dd_rsp),
    .s_address    (dd_s_addr_full),
    .s_burstcount (ddr_burstcount),
    .s_read       (ddr_read),
    .s_write      (ddr_write),
    .s_writedata  (ddr_writedata),
    .s_byteenable (ddr_byteenable),
    .s_waitrequest(ddr_waitrequest),
    .s_readdata   (ddr_readdata),
    .s_readdatavalid(ddr_readdatavalid),
    .s_response   (ddr_response)
);

assign i_s_wrq[1]  = dd_wrq[0];
assign d_s_wrq[DS_DDR] = dd_wrq[1];
assign fb_avm_wrq  = dd_wrq[2];

assign i_s_rdata[63:32]         = dd_rdat[31:0];
assign d_s_rdata[DS_DDR*32 +: 32] = dd_rdat[63:32];
assign fb_avm_rdata             = dd_rdat[95:64];

assign i_s_rv[1]     = dd_rv[0];
assign d_s_rv[DS_DDR] = dd_rv[1];
assign fb_avm_rv     = dd_rv[2];

assign i_s_resp[3:2]           = dd_rsp[1:0];
assign d_s_resp[DS_DDR*2 +: 2] = dd_rsp[3:2];

assign ddr_address = dd_s_addr_full[29:0];

// ===========================================================================
// debug: cpu bus activity counters + live levels (clk domain)
//   [15:0]  ib_acc   iBus command accepts
//   [31:16] ib_rdv   iBus readdatavalid beats
//   [47:32] db_acc   dBus command accepts (rd+wr)
//   [63:48] db_rdv   dBus readdatavalid beats
//   [95:64] ib_addr  last accepted iBus address
//   [127:96] live: {reset_out, ib_rd, ib_wrn, db_rd, db_wr, db_wrn, ib_rdv_l, db_rdv_l}
// ===========================================================================
reg [15:0] dbg_ib_acc = 0, dbg_ib_rdv = 0, dbg_db_acc = 0, dbg_db_rdv = 0;
reg [31:0] dbg_ib_addr = 0;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        dbg_ib_acc <= 0; dbg_ib_rdv <= 0;
        dbg_db_acc <= 0; dbg_db_rdv <= 0;
        dbg_ib_addr <= 0;
    end else begin
        if (cpu_ibus_rd && cpu_ibus_wrn) begin
            dbg_ib_acc  <= dbg_ib_acc + 1'b1;
            dbg_ib_addr <= cpu_ibus_addr;
        end
        if (cpu_ibus_rdv) dbg_ib_rdv <= dbg_ib_rdv + 1'b1;
        if ((cpu_dbus_rd || cpu_dbus_wr) && cpu_dbus_wrn) begin
            dbg_db_acc  <= dbg_db_acc + 1'b1;
            dbg_ib_addr <= cpu_dbus_addr;
        end
        if (cpu_dbus_rdv) dbg_db_rdv <= dbg_db_rdv + 1'b1;
    end
end

assign dbg = {
    /* [127:96]  */ chip_dbg,
    /* [95:64]   */ dbg_ib_addr,
    /* [63:48]   */ dbg_db_rdv,
    /* [47:32]   */ dbg_db_acc,
    /* [31:16]   */ dbg_ib_rdv,
    /* [15:0]    */ dbg_ib_acc
};

endmodule
