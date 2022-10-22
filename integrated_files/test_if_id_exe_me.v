`include "Execution_unit.v"
`include "if_unit.v"
`include "memoryut.v"
`include "id_unit.v"
`include "wb_unit.v"

module Exe_mem;
wire clkwire;
reg clk; 
reg [7:0] pc;
wire [19: 0] ciwire;
reg [19:0] current_instruction;
wire [15:0] regwire1, regwire2, regwire3, regwire4, regwire5, regwire6, regwire7, regwire8;
wire [15:0] reg1_out, reg2_out, reg3_out, reg4_out, reg5_out, reg6_out, reg7_out, reg8_out;
reg [15:0] reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8;    
reg [7:0] npc_in, imm, npci;
reg [15:0] op1, op2, AluOutput_reg;
reg [3:0] ldsti, regdesti, instructioni, regNos_reg;
wire [15:0] reg_data_1_wire,reg_data_2_wire, ALU_output, AluOutput; 
wire [3:0] instruction_4_bits, regNos, dest_reg_wire, regdest, ldst, instruction,  memwire;
wire [7:0] instrwire, npc_out, npc, npcwire;
reg [3:0] inst;
wire [15:0] wdata;
wire checkwdata=0;
reg [15:0] aluoutput, Data_from_mem;
reg [3:0] linenum;
wire [3:0] regnum,opcode_out;
reg [3:0] registernum;

assign clkwire = clk;
assign regwire1 = reg1;
assign regwire2 = reg2;
assign regwire3 = reg3;
assign regwire4 = reg4;
assign regwire5 = reg5;
assign regwire6 = reg6;
assign regwire7 = reg7;
assign regwire8 = reg8;
assign regNos = regNos_reg;
assign AluOutput = AluOutput_reg;

//assign jump_address_wire = jump_address;
//assign jump_selector_wire = jump_selector;

if_unit iftest(.clkwire(clkwire), .pc(pc), .instructionwire(ciwire), .npcwire(npcwire));

id_unit S2(.clkwire(clkwire),.regwire1(reg1),.regwire2(reg2),.regwire3(reg3),.regwire4(reg4),.regwire5(reg5),.regwire6(reg6),.regwire7(reg7),.regwire8(reg8),.current_instruction(current_instruction),.npc_in(npc_in),.reg_data_1_wire(reg_data_1_wire),.reg_data_2_wire(reg_data_2_wire),.instruction_4_bits(instruction_4_bits),.dest_reg_wire(dest_reg_wire),.npc_out(npc_out),.memwire(memwire),.instrwire(instrwire));

memory_unit dut (.clkwire (clkwire), .checkwritedata (checkwdata), .instruction (inst), .linenum(linenum), .writedata (wdata), .aluoutput(aluoutput), .regnum(regnum), .registernum(registernum),.opcode_out(opcode_out));

Execution_unit dut2(.clkwire(clkwire), .op1(op1), .op2(op2), .imm(imm), .npci(npci), .regdesti(regdesti), .ldsti(ldsti), .regdest(regdest), .ldst(ldst), .instructioni(instructioni),.instruction(instruction), .npc(npc),  .ALU_output(ALU_output));

write_back D(.clkwire(clkwire), .instruction(instruction), .regNos(regNos), .AluOutput(AluOutput), .Data_from_mem(Data_from_mem), .reg1_in(regwire1),.reg2_in(regwire2), .reg3_in(regwire3), .reg4_in(regwire4), .reg5_in(regwire5), .reg6_in(regwire6), .reg7_in(regwire7), .reg8_in(regwire8),.reg1_out(reg1_out),.reg2_out(reg2_out),.reg3_out(reg3_out),.reg4_out(reg4_out),.reg5_out(reg5_out),.reg6_out(reg6_out),.reg7_out(reg7_out),.reg8_out(reg8_out) );

always #2.5
begin
    clk = ~clk;
end

 initial 
    begin
    clk = 1'b0;
    pc = 8'b0;
    $dumpfile("dump4.vcd");
    $dumpvars;
	reg1=5;
    reg2=6;
    reg3=7;
    reg4=8;
    reg5=9;
    reg6=10;
    reg7=11;
    reg8=12;
    //current_instruction=20'b01000000000000100000;
    // current_instruction=20'b00110000001000000000;
    // npc_in=8'b00000010; 
    // #10 
    // current_instruction=20'b01000110011100000000;
      #50 $finish;
    end
always @(negedge clk)
begin
    current_instruction = ciwire;
    npc_in = npcwire;
// end

// always @(negedge clk)
// begin
    op1 = reg_data_1_wire;
    op2 = reg_data_2_wire;
    ldsti = memwire;
    npci = npc_out;
    regdesti = dest_reg_wire;
    instructioni = instruction_4_bits;
    imm = instrwire;
    $display("current instruction is %b", current_instruction);
      $display("dest_reg %b",dest_reg_wire, "data_1 is ", reg_data_1_wire, " data_2 is ", reg_data_2_wire);
       $display("mem: %b", memwire);
       $display("npc: %b", npc_out);
       $display("opcode: %b", instruction_4_bits, "instr: %b", instrwire);
       $display("operands are", op1, op2, instructioni, " (add) outputs are", instruction, ALU_output,  " ",npc, ldst);
        $display("wdata is", wdata,"data in:",Data_from_mem);
       $display("w in", AluOutput);
       $display("New registers are ", reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8);
end
    always @(negedge clk)
    begin
        inst=instruction; //mem
        aluoutput = ALU_output; //mem
        linenum=ldst; //mem
        registernum=regdest; //mem
        pc =  npc;
        AluOutput_reg = ALU_output;
        Data_from_mem = wdata;
        regNos_reg = regnum;
        reg1 = reg1_out;
        reg2 = reg2_out;
        reg3 = reg3_out;
        reg4 = reg4_out;
        reg5 = reg5_out;
        reg6 = reg6_out;
        reg7 = reg7_out;
        reg8 = reg8_out;
    end
endmodule