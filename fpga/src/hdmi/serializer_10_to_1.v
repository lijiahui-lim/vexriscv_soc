module serializer_10_to_1(
    input           serial_clk_5x,      // 输入串行数据时钟
    input   [9:0]   paralell_data,      // 输入并行数据

    output 			serial_data_p,      // 输出串行差分数据P
    output 			serial_data_n       // 输出串行差分数据N
    );
    
//reg define
reg   [2:0]  bit_cnt;    
reg   [4:0]  datain_rise_shift;
reg   [4:0]  datain_fall_shift;

//wire define
wire  [4:0]  datain_rise;    
wire  [4:0]  datain_fall;
  
//*****************************************************
//**                    main code
//*****************************************************

//上升沿发送Bit[8]/Bit[6]/Bit[4]/Bit[2]/Bit[0]
assign  datain_rise = {paralell_data[8],paralell_data[6],paralell_data[4],paralell_data[2],paralell_data[0]};

//下降沿发送Bit[9]/Bit[7]/Bit[5]/Bit[3]/Bit[1]                       
assign  datain_fall = {paralell_data[9],paralell_data[7],paralell_data[5],paralell_data[3],paralell_data[1]};

//位计数器赋值
always @(posedge serial_clk_5x) begin
    bit_cnt <= bit_cnt[2] ? 3'd0 : bit_cnt + 3'd1;
end                       

//移位赋值，发送并行数据的每一位
always @(posedge serial_clk_5x) begin
    if(bit_cnt[2]) begin               
        datain_rise_shift <= datain_rise;
        datain_fall_shift <= datain_fall; 
    end else begin
        datain_rise_shift <= {1'B0,datain_rise_shift[4:1]};
        datain_fall_shift <= {1'B0,datain_fall_shift[4:1]};
    end    
end                     

// pipeline stage before the DDR output cell: the shift register fans out
// to four IOB flops and the last hop misses 375 MHz timing by ~0.2 ns.
// Registering here lets the fitter pull the source next to the IOE.
// +1 serial_clk_5x cycle of latency is identical across all four
// serializers, so lane alignment is preserved.
reg out_rise_p, out_fall_p, out_rise_n, out_fall_n;
always @(posedge serial_clk_5x) begin
    out_rise_p <= datain_rise_shift[0];
    out_fall_p <= datain_fall_shift[0];
    out_rise_n <= ~datain_rise_shift[0];
    out_fall_n <= ~datain_fall_shift[0];
end

//例化DDIO_OUT IP核
ddio_out  u_ddio_out_p(
    .datain_h    ( out_rise_p),
    .datain_l    ( out_fall_p),
    .outclock    (serial_clk_5x),
    .dataout     (serial_data_p)
    );

//例化DDIO_OUT IP核
ddio_out  u_ddio_out_n(
    .datain_h    ( out_rise_n),
    .datain_l    ( out_fall_n),
    .outclock    (serial_clk_5x),
    .dataout     (serial_data_n)
    );       
 
endmodule
