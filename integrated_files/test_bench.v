`include "Execution_unit.v"
// Code your testbench here
// or browse Examples
module test_bench;
  wire clkwire;
  reg [15:0] op1, op2;
  reg clk;
  reg [7:0] imm, npci;
  reg [3:0] ldsti, regdesti, instructioni;
  wire[15:0] ALU_output;
  wire [7:0] jump_address;
  wire jump_selector;
  wire[3:0] regdest, ldst, instruction;
  Execution_unit dut(.clkwire(clkwire), .op1(op1), .op2(op2), .imm(imm),  .regdesti(regdesti), .ldsti(ldsti), .regdest(regdest), .ldst(ldst), .instructioni(instructioni),.instruction(instruction), .jump_address(jump_address), .jump_selector(jump_selector), .ALU_output(ALU_output));
  assign clkwire = clk;
  always #2
    begin 
      //$display(clk);
      clk = ~clk;
    end
  initial
	begin
          
$dumpfile("dump.vcd");
$dumpvars;
	clk = 1'b0;
	op1 = 10; op2 = 12; imm = 15; npci = 10; regdesti = 5; ldsti= 9; instructioni = 4'b0000;
      #4  $display("operands are", op1, op2, instructioni, " (add) outputs are", instruction, ALU_output,  " ",jump_address, " ", jump_selector);

op1 = 12; op2 = 3; imm = 15; npci = 10; regdesti = 5; ldsti= 9; instructioni = 4'b0001;
      #4      $display("operands are", op1, op2, instructioni, " (sub) outputs are", instruction, ALU_output, " ",jump_address, " ", jump_selector);

op1 = 4; op2 = 7; imm = 15; npci = 10; regdesti = 5; ldsti= 9;  instructioni = 4'b0010;
      #4      $display("operands are", op1, op2, instructioni, " (mul) outputs are", instruction, ALU_output, " ",jump_address, " ", jump_selector);

op1 = 14; op2 = 14; imm = 15; npci = 10; regdesti = 5; ldsti= 9; instructioni = 4'b0101;
      #4    $display("operands are", op1, op2, instructioni, " (beq) outputs are", instruction, ALU_output, " ",jump_address, " ", jump_selector);

op1 = 18; op2 = 20; imm = 15; npci = 10;  regdesti = 5; ldsti= 9; instructioni = 4'b0110;
      #4    $display("operands are", op1, op2, instructioni, " (bnq) outputs are", instruction, ALU_output, " ",jump_address, " ", jump_selector);

op1 = 17; op2 = 18; imm = 15; npci  = 10;  regdesti = 5; ldsti= 9; instructioni = 4'b0100;
      #4    $display("operands are", op1, op2, instructioni, " (store) outputs are", instruction, ALU_output, " ",jump_address, " ", jump_selector);

op1 = 17; op2 = 18; imm = 15; npci = 10;  regdesti = 5; ldsti= 9; instructioni = 4'b0011;
      #4   $display("operands are", op1, op2, instructioni, " (load) outputs are", instruction, ALU_output, " ",jump_address, " ", jump_selector);
#2
$finish;
	end
endmodule