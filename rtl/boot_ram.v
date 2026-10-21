// boot_ram: on-chip RAM, Avalon-MM slave, true dual port
//   port A = iBus side (read only), port B = dBus side (read+write).
// Read bursts: one accepted read (burstcount=N) returns N consecutive
// readdatavalid beats with auto-incrementing word addresses. New requests
// are stalled (waitrequest) until the current burst is fully served.
// $readmemh-initialized (Quartus infers M10K init from the initial block).
// All mem[] accesses live in ONE always block (1W2R) so Quartus infers
// a true dual-port M10K instead of flagging multiple constant drivers.
module boot_ram #(
    parameter WORDS = 8192,                    // 32 KiB
    parameter HEX   = ""
)(
    input  wire            clk,
    input  wire            reset_n,

    input  wire [31:0]     a_address,          // byte address
    input  wire [7:0]      a_burstcount,
    input  wire            a_read,
    input  wire            a_write,
    input  wire [31:0]     a_writedata,
    input  wire [3:0]      a_byteenable,
    output wire            a_waitrequest,
    output reg  [31:0]     a_readdata,
    output reg             a_readdatavalid,
    output wire [1:0]      a_response,

    input  wire [31:0]     b_address,
    input  wire [7:0]      b_burstcount,
    input  wire            b_read,
    input  wire            b_write,
    input  wire [31:0]     b_writedata,
    input  wire [3:0]      b_byteenable,
    output wire            b_waitrequest,
    output reg  [31:0]     b_readdata,
    output reg             b_readdatavalid,
    output wire [1:0]      b_response
);

localparam AW = $clog2(WORDS);

// Quartus 18.1 does NOT infer RAM from mem[addr][byte_sel] <= partial writes.
// Split into four byte-wide memories -> infers 8x M10K (x2 replication for
// the two read ports). Init: synthesis reads four per-lane files
// (boot.hex.b0..b3); simulation loads the single 32-bit file then splits.
(* ramstyle = "M10K" *) reg [7:0] mem0 [0:WORDS-1];
(* ramstyle = "M10K" *) reg [7:0] mem1 [0:WORDS-1];
(* ramstyle = "M10K" *) reg [7:0] mem2 [0:WORDS-1];
(* ramstyle = "M10K" *) reg [7:0] mem3 [0:WORDS-1];

initial begin
`ifdef SYNTHESIS
    $readmemh("boot.hex.b0", mem0);
    $readmemh("boot.hex.b1", mem1);
    $readmemh("boot.hex.b2", mem2);
    $readmemh("boot.hex.b3", mem3);
`else
    if (HEX != "") begin : g_load
        reg [31:0] tmp [0:WORDS-1];
        integer i;
        $readmemh(HEX, tmp);
        for (i = 0; i < WORDS; i = i + 1) begin
            mem0[i] = tmp[i][7:0];
            mem1[i] = tmp[i][15:8];
            mem2[i] = tmp[i][23:16];
            mem3[i] = tmp[i][31:24];
        end
    end
`endif
end

assign a_response = 2'b00;
assign b_response = 2'b00;

// ---------------- port A burst bookkeeping ----------------
reg  [7:0]  a_bl;                            // beats left after first
reg  [31:0] a_ba;                            // next beat address

wire a_fire = a_read && !a_waitrequest;
wire a_adv  = a_fire || (a_bl != 8'd0);
wire [31:0] a_adr = a_fire ? a_address : a_ba;

assign a_waitrequest = (a_bl != 8'd0);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        a_bl <= 8'd0; a_ba <= 32'd0;
        a_readdatavalid <= 1'b0;
    end else begin
        a_readdatavalid <= a_adv;
        if (a_fire) begin
            a_bl <= a_burstcount - 8'd1;
            a_ba <= a_address + 32'd4;
        end else if (a_bl != 8'd0) begin
            a_bl <= a_bl - 8'd1;
            a_ba <= a_ba + 8'd4;
        end
    end
end

// ---------------- port B burst bookkeeping ----------------
reg  [7:0]  b_bl;
reg  [31:0] b_ba;

wire b_fire = b_read && !b_waitrequest;
wire b_adv  = b_fire || (b_bl != 8'd0);
wire [31:0] b_adr = b_fire ? b_address : b_ba;

assign b_waitrequest = (b_bl != 8'd0);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        b_bl <= 8'd0; b_ba <= 32'd0;
        b_readdatavalid <= 1'b0;
    end else begin
        b_readdatavalid <= b_adv;
        if (b_fire) begin
            b_bl <= b_burstcount - 8'd1;
            b_ba <= b_address + 32'd4;
        end else if (b_bl != 8'd0) begin
            b_bl <= b_bl - 8'd1;
            b_ba <= b_ba + 8'd4;
        end
    end
end

// ---------------- memory access: Quartus dual-port RAM template ------
// one always block per port, byte-lane memories touched nowhere else
always @(posedge clk) begin
    a_readdata <= {mem3[a_adr[AW+1:2]], mem2[a_adr[AW+1:2]],
                   mem1[a_adr[AW+1:2]], mem0[a_adr[AW+1:2]]};
end

always @(posedge clk) begin
    b_readdata <= {mem3[b_adr[AW+1:2]], mem2[b_adr[AW+1:2]],
                   mem1[b_adr[AW+1:2]], mem0[b_adr[AW+1:2]]};
    if (b_write) begin
        if (b_byteenable[0]) mem0[b_address[AW+1:2]] <= b_writedata[7:0];
        if (b_byteenable[1]) mem1[b_address[AW+1:2]] <= b_writedata[15:8];
        if (b_byteenable[2]) mem2[b_address[AW+1:2]] <= b_writedata[23:16];
        if (b_byteenable[3]) mem3[b_address[AW+1:2]] <= b_writedata[31:24];
    end
end

endmodule
