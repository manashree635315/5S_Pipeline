`include "memoryut.v"
module test_memoryut;
wire clkwire;
reg pc;
reg [3:0] inst;
wire [15:0] wdata;
wire checkwdata=0;
reg indata;
reg clk;
reg [15:0] aluoutput;
reg [3:0] linenum;
wire regnum;
reg [3:0] registernum;

memory_unit dut (.clkwire (clkwire),
    .checkwritedata (checkwdata),
    .instruction (inst),
    .linenum(linenum),
    .writedata (wdata),
    .aluoutput(aluoutput),
    .regnum(regnum),
    .registernum(registernum));
assign clkwire=clk;
always #5
begin
    clk = ~clk;
end

initial begin
    // $display("karoo");
    clk =1'b0;
// $monitor ("heyllo");
// $display("hmm");
$dumpfile("try.vcd");
$dumpvars;
// $display("kmm");
clk=1'b1;
// inst=4'b0001;
// linenum=4'b0011;
// aluoutput=16'b0000000000001011;
// // $display("smm");
// #5
inst=4'b0011;
aluoutput=16'b0000000000000101;
linenum=4'b1001;
registernum=4'b0110;
// $display("jmm");
// $dumpvars;
// $display("pmm");
#5
// $display("lmm");
$finish;
end
endmodule