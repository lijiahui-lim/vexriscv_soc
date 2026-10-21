// avl2apb: Avalon-MM slave port -> APB3 master. One transaction in
// flight; each Avalon beat runs a full APB setup+access cycle.
module avl2apb #(
    parameter AW = 20,                         // apb window address bits
    parameter DW = 32
)(
    input  wire            clk,
    input  wire            reset_n,

    // Avalon slave port (byte address; only low AW bits used)
    input  wire [AW-1:0]   avl_address,
    input  wire            avl_read,
    input  wire            avl_write,
    input  wire [DW-1:0]   avl_writedata,
    input  wire [DW/8-1:0] avl_byteenable,
    output wire            avl_waitrequest,
    output reg  [DW-1:0]   avl_readdata,
    output reg             avl_readdatavalid,
    output wire [1:0]      avl_response,

    // APB3 master port
    output reg  [AW-1:0]   apb_paddr,
    output reg             apb_psel,
    output reg             apb_penable,
    output reg             apb_pwrite,
    output reg  [DW-1:0]   apb_pwdata,
    input  wire [DW-1:0]   apb_prdata,
    input  wire            apb_pready,
    input  wire            apb_pslverr
);

localparam S_SETUP  = 2'd0,
           S_ACCESS = 2'd1,
           S_DONE   = 2'd2;

reg [1:0] state = S_SETUP;
reg       was_read;
reg       pseld;

assign avl_waitrequest = !(state == S_SETUP && !pseld);
assign avl_response    = 2'b00;

wire accept = (avl_read || avl_write) && !avl_waitrequest;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state <= S_SETUP;
        apb_psel <= 0; apb_penable <= 0; pseld <= 0;
        avl_readdatavalid <= 0;
        was_read <= 0;
    end else begin
        avl_readdatavalid <= 0;
        case (state)
        S_SETUP: begin
            apb_penable <= 0;
            if (accept) begin
                apb_paddr  <= avl_address;
                apb_pwrite <= avl_write;
                apb_pwdata <= avl_writedata;
                apb_psel   <= 1;
                pseld      <= 1;
                was_read   <= avl_read;
                state      <= S_ACCESS;
            end else
                pseld <= 0;
        end
        S_ACCESS: begin
            apb_penable <= 1;
            // complete only after penable has been high for a full cycle
            if (apb_penable && apb_pready) begin
                apb_psel    <= 0;
                apb_penable <= 0;
                pseld       <= 0;
                if (was_read) begin
                    avl_readdata      <= apb_prdata;
                    avl_readdatavalid <= 1;
                end
                state <= S_SETUP;
            end
        end
        default: state <= S_SETUP;
        endcase
    end
end

endmodule
