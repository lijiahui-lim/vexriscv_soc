// sim_emif: behavioral model of the UniPHY avl port (192-bit, half-rate).
//   waitrequest_n is ACTIVE-LOW (matches UniPHY convention).
//   Commands are single 192-bit-word accesses (mavl_burstcount is always 1
//   from ddr_avl_bridge); a read is serviced RD_LATENCY cycles after accept.
//   Adds light pseudo-random backpressure to exercise the hold logic.
module sim_emif #(
    parameter WORDS = 65536,                   // 65536 * 24B = 1.5 MB
    parameter RD_LATENCY = 8,
    parameter DDR_HEX = ""                     // optional 32b-words preload
)(
    input  wire         clk,
    input  wire         reset_n,

    input  wire [24:0]  mavl_address,          // 24B word units
    input  wire [2:0]   mavl_burstcount,
    input  wire         mavl_write,
    input  wire [191:0] mavl_writedata,
    input  wire [23:0]  mavl_byteenable,
    input  wire         mavl_read,
    input  wire         mavl_beginbursttransfer,
    output wire         mavl_waitrequest_n,
    output reg  [191:0] mavl_readdata,
    output reg          mavl_readdatavalid
);

reg [191:0] mem [0:WORDS-1];

// optional preload: DDR_HEX is a $readmemh file of 32-bit words, packed
// six-per-avl-word little-endian (word 0 -> lane 0 = bits 31:0)
initial begin
    if (DDR_HEX != "") begin : load
        reg [31:0] flat [0:6*WORDS-1];
        integer i;
        $readmemh(DDR_HEX, flat);
        for (i = 0; i < WORDS; i = i + 1)
            mem[i] = {flat[i*6+5], flat[i*6+4], flat[i*6+3],
                      flat[i*6+2], flat[i*6+1], flat[i*6+0]};
    end
end

// light random backpressure (~1/8 stall), and force read-return gaps
reg [7:0] lfsr = 8'hA5;
always @(posedge clk) lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3]};
wire stall = lfsr[2:0] == 3'b111;

assign mavl_waitrequest_n = !stall;

wire rd_acc = mavl_read  && mavl_waitrequest_n;
wire wr_acc = mavl_write && mavl_waitrequest_n;

// writes
integer bi;
always @(posedge clk) begin
    if (wr_acc) begin
        for (bi = 0; bi < 24; bi = bi + 1)
            if (mavl_byteenable[bi])
                mem[mavl_address % WORDS][bi*8 +: 8] <= mavl_writedata[bi*8 +: 8];
    end
end

// read: capture address at accept, respond after RD_LATENCY
reg [191:0] rdq_data [0:63];
reg [5:0]   rdq_wp = 0, rdq_rp = 0;
reg [5:0]   rdq_timer [0:63];
reg         rdq_v    [0:63];
integer qi;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        rdq_wp <= 0; rdq_rp <= 0;
        mavl_readdatavalid <= 0; mavl_readdata <= 0;
        for (qi = 0; qi < 64; qi = qi + 1) begin
            rdq_v[qi] <= 0; rdq_timer[qi] <= 0;
        end
    end else begin
        mavl_readdatavalid <= 0;
        if (rd_acc) begin
            rdq_data [rdq_wp] <= mem[mavl_address % WORDS];
            rdq_timer[rdq_wp] <= RD_LATENCY;
            rdq_v    [rdq_wp] <= 1'b1;
            rdq_wp <= rdq_wp + 1'b1;
        end
        if (rdq_v[rdq_rp]) begin
            if (rdq_timer[rdq_rp] != 0)
                rdq_timer[rdq_rp] <= rdq_timer[rdq_rp] - 1'b1;
            else begin
                rdq_v[rdq_rp] <= 0;
                rdq_rp <= rdq_rp + 1'b1;
                mavl_readdata      <= rdq_data[rdq_rp];
                mavl_readdatavalid <= 1'b1;
            end
        end
    end
end

endmodule
