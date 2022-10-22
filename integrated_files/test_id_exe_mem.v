`include "Execution_unit.v"
`include "memoryut.v"
`include "id_unit.v"
module Exe_mem;
wire clkwire;
reg clk;
reg [15:0] regwire1,regwire2,regwire3,regwire4,regwire5,regwire6,regwire7,regwire8;
    reg [19:0] current_instruction;
    reg [7:0] npc_in, imm, npci;
    reg [15:0] op1, op2;
    reg [3:0] ldsti, regdesti, instructioni;
    wire [15:0] reg_data_1_wire,reg_data_2_wire, ALU_output; 
    wire [3:0] instruction_4_bits, dest_reg_wire, regdest, ldst, instruction,  memwire;
    wire [7:0] instrwire, npc_out, npc;
reg [3:0] inst;
wire [15:0] wdata;
wire checkwdata=0;
reg [15:0] aluoutput;
reg [3:0] linenum;
wire regnum;
reg [3:0] registernum;

id_unit S2(.clkwire(clkwire),.regwire1(regwire1),.regwire2(regwire2),.regwire3(regwire3),.regwire4(regwire4),.regwire5(regwire5),.regwire6(regwire6),.regwire7(regwire7),.regwire8(regwire8),.current_instruction(current_instruction),.npc_in(npc_in),.reg_data_1_wire(reg_data_1_wire),.reg_data_2_wire(reg_data_2_wire),.instruction_4_bits(instruction_4_bits),.dest_reg_wire(dest_reg_wire),.npc_out(npc_out),.memwire(memwire),.instrwire(instrwire));
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
     $dumpfile("dump3.vcd");
     $dumpvars;
	regwire1=5;
    regwire2=6;
    regwire3=7;
    regwire4=8;
    regwire5=9;
    regwire6=10;
    regwire7=11;
    regwire8=12;
    // current_instruction=20'b01000000000000100000;
    current_instruction=20'b00110000001000000000;
    npc_in=8'b00000010; 
    #10 
    current_instruction=20'b01000110011100000000;
      #50 $finish;
    end

always @(negedge clk)
begin
    op1 = reg_data_1_wire;
    op2 = reg_data_2_wire;
    ldsti = memwire;
    npci = npc_out;
    regdesti = dest_reg_wire;
    instructioni = instruction_4_bits;
    imm = instrwire;
    $display("current instruction is %b",current_instruction);
      $display("dest_reg %b",dest_reg_wire);
       $display("reg_data_1 is ", reg_data_1_wire);
       $display("reg_data_2 is ", reg_data_2_wire);
       $display("mem: %b", memwire);
       $display("npc: %b", npc_out);
       $display("opcode: %b", instruction_4_bits);
       $display("instr: %b", instrwire);
        $display("operands are", op1, op2, instructioni, " (add) outputs are", instruction, ALU_output,  " ",npc, ldst);
    
end
    always @(negedge clk)
    begin
        inst=instruction;
        aluoutput=ALU_output;
        linenum=ldst;
        registernum=regdest;
    end
endmodule