// avl2axil: Avalon-MM master port -> AXI4-Lite master (for the CPU's
// integrated clint/plic slaves). One transaction in flight; each Avalon
// beat is run to completion (B or R channel) before the next is accepted.
module avl2axil #(
    parameter AW = 32,
    parameter DW = 32
)(
    input  wire            clk,
    input  wire            reset_n,

    // Avalon-MM slave port (driven by the fabric)
    input  wire [AW-1:0]   avl_address,
    input  wire            avl_read,
    input  wire            avl_write,
    input  wire [DW-1:0]   avl_writedata,
    input  wire [DW/8-1:0] avl_byteenable,
    output wire            avl_waitrequest,
    output reg  [DW-1:0]   avl_readdata,
    output reg             avl_readdatavalid,
    output wire [1:0]      avl_response,

    // AXI4-Lite master port (to clint/plic inside the CPU complex)
    output reg  [AW-1:0]   axil_awaddr,
    output reg             axil_awvalid,
    input  wire            axil_awready,
    output reg  [DW-1:0]   axil_wdata,
    output reg  [DW/8-1:0] axil_wstrb,
    output reg             axil_wvalid,
    input  wire            axil_wready,
    input  wire [1:0]      axil_bresp,
    input  wire            axil_bvalid,
    output wire            axil_bready,
    output reg  [AW-1:0]   axil_araddr,
    output reg             axil_arvalid,
    input  wire            axil_arready,
    input  wire [DW-1:0]   axil_rdata,
    input  wire [1:0]      axil_rresp,
    input  wire            axil_rvalid,
    output wire            axil_rready
);

localparam S_IDLE = 2'd0,
           S_WR   = 2'd1,
           S_B    = 2'd2,
           S_RD   = 2'd3;

reg [1:0] state = S_IDLE;
reg       rd_pend;

assign avl_waitrequest = (state != S_IDLE);
wire accept = (state == S_IDLE) && (avl_read || avl_write);

assign axil_bready = (state == S_B);
assign axil_rready = (state == S_RD);
assign avl_response = 2'b00;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state <= S_IDLE;
        axil_awvalid <= 1'b0;
        axil_wvalid  <= 1'b0;
        axil_arvalid <= 1'b0;
        avl_readdatavalid <= 1'b0;
        rd_pend <= 1'b0;
    end else begin
        avl_readdatavalid <= 1'b0;
        case (state)
        S_IDLE: if (accept) begin
            if (avl_write) begin
                axil_awaddr  <= avl_address;
                axil_wdata   <= avl_writedata;
                axil_wstrb   <= avl_byteenable;
                axil_awvalid <= 1'b1;
                axil_wvalid  <= 1'b1;
                state <= S_WR;
            end else begin
                axil_araddr  <= avl_address;
                axil_arvalid <= 1'b1;
                rd_pend <= 1'b1;
                state <= S_RD;
            end
        end
        S_WR: begin
            if (axil_awready) axil_awvalid <= 1'b0;
            if (axil_wready)  axil_wvalid  <= 1'b0;
            if (!axil_awvalid && !axil_wvalid) state <= S_B;
        end
        S_B:  if (axil_bvalid) state <= S_IDLE;
        S_RD: begin
            if (axil_arready) axil_arvalid <= 1'b0;
            if (axil_rvalid) begin
                avl_readdata <= axil_rdata;
                avl_readdatavalid <= 1'b1;
                state <= S_IDLE;
            end
        end
        endcase
    end
end

endmodule
