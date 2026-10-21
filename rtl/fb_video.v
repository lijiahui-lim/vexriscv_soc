// fb_video: 1280x720 video timing (same timing as the original colorbar
// design's 720p row), pulling pixels from the fb_reader FIFO one per clock
// during the active window. vsync_out is high during the vertical sync
// lines; fb_reader uses it to restart the frame.

module fb_video (
    input  wire        pixel_clk,
    input  wire        rst_n,

    output wire        video_hs,
    output wire        video_vs,
    output wire        video_de,
    output wire [23:0] video_rgb,

    input  wire [23:0] pix_rgb,
    input  wire        pix_empty,
    output wire        pix_rd,
    output wire        vsync_out
);

parameter H_FP    = 12'd110;
parameter H_SYNC  = 12'd40;
parameter H_BP    = 12'd220;
parameter H_VALID = 12'd1280;
parameter V_FP    = 12'd5;
parameter V_SYNC  = 12'd5;
parameter V_BP    = 12'd20;
parameter V_VALID = 12'd720;
parameter HS_Pol  = 1'b1;
parameter VS_Pol  = 1'b1;

localparam H_TOTAL = H_SYNC + H_BP + H_VALID + H_FP;
localparam V_TOTAL = V_SYNC + V_BP + V_VALID + V_FP;

reg [12:0] cnt_h;
reg [12:0] cnt_v;

always @(posedge pixel_clk) begin
    if (!rst_n)
        cnt_h <= 13'd0;
    else if (cnt_h < H_TOTAL - 1'b1)
        cnt_h <= cnt_h + 1'b1;
    else
        cnt_h <= 13'd0;
end

always @(posedge pixel_clk) begin
    if (!rst_n)
        cnt_v <= 13'd0;
    else if (cnt_h == H_TOTAL - 1'b1)
        cnt_v <= (cnt_v < V_TOTAL - 1'b1) ? cnt_v + 1'b1 : 13'd0;
end

assign video_hs = (cnt_h < H_SYNC) ? ~HS_Pol : HS_Pol;
assign video_vs = (cnt_v < V_SYNC) ? ~VS_Pol : VS_Pol;
assign video_de = ((cnt_h >= H_SYNC + H_BP) && (cnt_h < H_SYNC + H_BP + H_VALID))
               && ((cnt_v >= V_SYNC + V_BP) && (cnt_v < V_SYNC + V_BP + V_VALID));

assign pix_rd    = video_de;
assign video_rgb = video_de ? pix_rgb : 24'd0;
assign vsync_out = (cnt_v < V_SYNC);

endmodule
