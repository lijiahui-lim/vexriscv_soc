// avl_demux: 1 Avalon-MM master -> N slaves address decoder.
//
// - Decode: slave i selected when (addr & MASK_i) == BASE_i.
// - Writes are forwarded per-beat (no response needed).
// - Reads: each accepted read beat produces exactly one response beat on
//   the chosen slave. To keep response ordering correct when different
//   slaves have different latencies, a read to slave Y is stalled while
//   reads to another slave are still outstanding.
// - An unmapped access hits the built-in error slave: writes are dropped,
//   each read beat returns readdatavalid with response = DECODEERROR (11).
//
// Avalon notes: address is a byte address; burstcount is forwarded
// verbatim (first beat of a burst carries the total beat count).
module avl_demux #(
    parameter N               = 4,
    parameter AW              = 32,
    parameter DW              = 32,
    parameter BW              = 8,                    // burstcount width
    parameter [N*AW-1:0] BASE = {N*AW{1'b0}},
    parameter [N*AW-1:0] MASK = {N*AW{1'b0}},
    parameter SW              = (N <= 1) ? 1 : $clog2(N)
)(
    input  wire            clk,
    input  wire            reset_n,

    // master-side slave port
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

    // slave-side master ports (packed)
    output wire [N*AW-1:0]   s_address,
    output wire [N*BW-1:0]   s_burstcount,
    output wire [N-1:0]      s_read,
    output wire [N-1:0]      s_write,
    output wire [N*DW-1:0]   s_writedata,
    output wire [N*DW/8-1:0] s_byteenable,
    input  wire [N-1:0]      s_waitrequest,
    input  wire [N*DW-1:0]   s_readdata,
    input  wire [N-1:0]      s_readdatavalid,
    input  wire [N*2-1:0]    s_response
);

genvar gi;
wire [N-1:0] sel;
generate
for (gi = 0; gi < N; gi = gi + 1) begin : g_sel
    assign sel[gi] = ((m_address & MASK[gi*AW +: AW]) == BASE[gi*AW +: AW]);
end
endgenerate
wire mapped = |sel;
wire [SW:0] sel_id;                       // one-hot -> binary, N = error slave
reg  [SW:0] sel_id_r;
integer k;
always @(*) begin
    sel_id_r = N[SW:0];
    for (k = 0; k < N; k = k + 1)
        if (sel[k]) sel_id_r = k[SW:0];
end
assign sel_id = sel_id_r;

// ---- outstanding-read tracking ---------------------------------------
reg  [SW:0] rd_sid    = {SW+1{1'b0}};
reg  [7:0]  rd_pend   = 8'd0;             // beats accepted, not yet returned
wire        rd_idle   = (rd_pend == 8'd0);
// block reads that would go to a different slave while reads are pending
wire        rd_block  = m_read && !rd_idle && (sel_id != rd_sid);

wire [SW:0] cur_sid   = rd_idle ? sel_id : rd_sid;

// ---- error slave ------------------------------------------------------
reg err_busy = 1'b0;
reg err_was_read;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        err_busy     <= 1'b0;
        err_was_read <= 1'b0;
    end else begin
        if (!err_busy && (m_read || m_write) && !mapped && !m_waitrequest) begin
            err_busy     <= 1'b1;
            err_was_read <= m_read;
        end else if (err_busy) begin
            err_busy <= 1'b0;            // 1-cycle service
        end
    end
end
wire err_rd  = err_busy && err_was_read;

// ---- forward cmd to selected slave ------------------------------------
generate
for (gi = 0; gi < N; gi = gi + 1) begin : g_fwd
    assign s_address   [gi*AW +: AW]   = m_address;
    assign s_burstcount[gi*BW +: BW]   = m_burstcount;
    assign s_writedata [gi*DW +: DW]   = m_writedata;
    assign s_byteenable[gi*DW/8 +: DW/8] = m_byteenable;
    assign s_read [gi] = m_read  && sel[gi] && !rd_block;
    assign s_write[gi] = m_write && sel[gi];
end
endgenerate

// waitrequest: err slave accepts only when it is free; selected slave drives
wire sel_wr = mapped ? s_waitrequest[sel_id[SW-1:0]] : err_busy;
assign m_waitrequest = rd_block ? 1'b1 : sel_wr;

// count outstanding read beats: one accepted read request produces
// burstcount response beats
wire rd_accept = m_read && !m_waitrequest;
wire rd_ret    = m_readdatavalid;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        rd_pend <= 8'd0;
        rd_sid  <= {SW+1{1'b0}};
    end else begin
        rd_pend <= rd_pend
                 + (rd_accept ? m_burstcount : 8'd0)
                 - (rd_ret    ? 8'd1          : 8'd0);
        if (rd_accept)
            rd_sid <= sel_id;
    end
end

// ---- response mux ------------------------------------------------------
wire [DW-1:0] rd_mux = (cur_sid == N[SW:0]) ? {DW{1'b0}} :
                        s_readdata[cur_sid[SW-1:0]*DW +: DW];
wire [1:0]    rp_mux = (cur_sid == N[SW:0]) ? 2'b11 :
                        s_response[cur_sid[SW-1:0]*2 +: 2];
wire          rv_mux = (cur_sid == N[SW:0]) ? err_rd :
                        s_readdatavalid[cur_sid[SW-1:0]];

assign m_readdata      = rd_mux;
assign m_response      = rp_mux;
assign m_readdatavalid = rv_mux;

endmodule
