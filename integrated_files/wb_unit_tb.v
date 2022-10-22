`include "wb_unit.v"
module write_back_tb;
 reg clk;
 wire clkwire_;
 assign clkwire_ = clk;
 reg [3 : 0] instruction_, regNos_;

 reg [15 : 0] 
 AluOutput_,
 Data_from_mem_,
 reg1_in_,
 reg2_in_,
 reg3_in_,
 reg4_in_,
 reg5_in_,
 reg6_in_,
 reg7_in_,
 reg8_in_;

 wire [15 : 0] 
 
 reg1_out_,
 reg2_out_,
 reg3_out_,
 reg4_out_,
 reg5_out_,
 reg6_out_,
 reg7_out_,
 reg8_out_;

 initial begin
    AluOutput_[15 : 0]=16'b0000000000000000;
    Data_from_mem_[15 : 0]=16'b0000000000000000;
    reg1_in_[15 : 0] = 16'b0000000000000000;
    reg2_in_[15 : 0] = 16'b0000000000000000;
    reg3_in_[15 : 0] = 16'b0000000000000000;
    reg4_in_[15 : 0] = 16'b0000000000000000;
    reg5_in_[15 : 0] = 16'b0000000000000000;
    reg6_in_[15 : 0] = 16'b0000000000000000;
    reg7_in_[15 : 0] = 16'b0000000000000000;
    reg8_in_[15 : 0] = 16'b0000000000000000;
  clk = 1'b0;
end
always #2.5
 begin clk = ~clk;   #5 $finish; end
 write_back example(clkwire_, instruction_, AluOutput_, Data_from_mem_, regNos_, reg1_in_, reg2_in_, reg3_in_, reg4_in_, reg5_in_, reg6_in_, reg7_in_, reg8_in_, reg1_out_, reg2_out_, reg3_out_, reg4_out_, reg5_out_, reg6_out_, reg7_out_, reg8_out_);

initial begin
    $dumpfile("write_back_tb.vcd");
    $dumpvars(0,write_back_tb);
    instruction_ = 4'b0000; AluOutput_ = 16'b0000000000001101; Data_from_mem_ = 16'b0000000000000000; reg1_in_ = 16'b0000000000000011;  regNos_ = 4'b0000;
    #5 instruction_ = 4'b0011; AluOutput_ = 16'b0000000000000000; Data_from_mem_ = 16'b0000000000001111;  regNos_ = 4'b0000;
    #5 $display(reg1_out_, reg2_out_, reg3_out_, reg4_out_, reg5_out_, reg6_out_, reg7_out_, reg8_out_ );
  
end
 endmodule