`include "Execution_unit.v"
`include "memoryut.v"
module Exe_mem;
wire clkwire;
reg [15:0] op1, op2;
reg clk;
reg [7:0] imm, npci;
reg [3:0] ldsti, regdesti, instructioni;
wire[15:0] ALU_output;
wire [7:0] npc;
wire[3:0] regdest, ldst, instruction;
reg [3:0] inst;
wire [15:0] wdata;
wire checkwdata=0;
reg [15:0] aluoutput;
reg [3:0] linenum;
wire regnum;
reg [3:0] registernum;

memory_unit dut (.clkwire (clkwire), .checkwritedata (checkwdata), .instruction (inst), .linenum(linenum), .writedata (wdata), .aluoutput(aluoutput), .regnum(regnum), .registernum(registernum));
Execution_unit dut2(.clkwire(clkwire), .op1(op1), .op2(op2), .imm(imm), .npci(npci), .regdesti(regdesti), .ldsti(ldsti), .regdest(regdest), .ldst(ldst), .instructioni(instructioni),.instruction(instruction), .npc(npc),  .ALU_output(ALU_output));
assign clkwire = clk;

always
begin
    #5
    clk = ~clk;
end
initial
	begin
          
	clk = 1'b0;
    $dumpfile("integration_mem_exe.vcd");
    $dumpvars;
	op1 = 10; op2 = 12; imm = 15; npci = 10; regdesti = 5; ldsti= 9; instructioni = 4'b0000;
      #10  $display("operands are", op1, op2, instructioni, " (add) outputs are", instruction, ALU_output,  " ",npc);

    op1 = 12; op2 = 3; imm = 15; npci = 10; regdesti = 5; ldsti= 9; instructioni = 4'b0001;
      #10      $display("operands are", op1, op2, instructioni, " (sub) outputs are", instruction, ALU_output, " ",npc);

    op1 = 4; op2 = 7; imm = 15; npci = 10; regdesti = 5; ldsti= 9;  instructioni = 4'b0010;
      #10      $display("operands are", op1, op2, instructioni, " (mul) outputs are", instruction, ALU_output, " ",npc);

    op1 = 14; op2 = 14; imm = 15; npci = 10; regdesti = 5; ldsti= 9; instructioni = 4'b0101;
      #10    $display("operands are", op1, op2, instructioni, " (beq) outputs are", instruction, ALU_output, " ",npc);

    op1 = 18; op2 = 18; imm = 15; npci = 10;  regdesti = 5; ldsti= 9; instructioni = 4'b0110;
      #10   $display("operands are", op1, op2, instructioni, " (bnq) outputs are", instruction, ALU_output, " ",npc);

    op1 = 17; op2 = 18; imm = 15; npci = 10;  regdesti = 5; ldsti= 9; instructioni = 4'b0100;
      #10    $display("operands are", op1, op2, instructioni, " (store) outputs are", instruction, ALU_output, " ",npc);

    op1 = 17; op2 = 18; imm = 15; npci = 10;  regdesti = 5; ldsti= 9; instructioni = 4'b0011;
      #10   $display("operands are", op1, op2, instructioni, " (load) outputs are", instruction, ALU_output, " ",npc);
    #5
    $finish;
    end
    always @(negedge clk)
    begin
        inst=instruction;
        aluoutput=ALU_output;
        linenum=ldst;
        registernum=regdest;
    end
endmodule