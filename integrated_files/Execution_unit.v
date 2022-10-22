// Code your design here
module Execution_unit(
  input wire clkwire,
  input[15:0] op1, op2,
  input[7:0]  imm,
  input[3:0] instructioni, regdesti,ldsti,
  output[15:0] ALU_output,
  output[3:0] regdest, ldst, instruction,
  output wire[7:0] jump_address,
  output wire jump_selector
);
  reg [15:0] ALU_result;
  reg [3:0] npc_reg, ldsti_reg, regdesti_reg, instruction_reg;
  reg jump_selector_reg;

  assign ALU_output = ALU_result;
  assign ldst = ldsti_reg;
  assign regdest = regdesti_reg;
  assign jump_address = npc_reg;
  assign jump_selector = jump_selector_reg;
  assign instruction = instruction_reg;
  always @(posedge clkwire)
    begin
      instruction_reg = instructioni;
      jump_selector_reg = 1'b0;
      case(instructioni)
      4'b0000:
        begin
        ALU_result = op1 + op2;
          npc_reg = 0; end
      4'b0001:
        begin
        ALU_result = op1 - op2;
          npc_reg = 0;end
      4'b0010:
        begin
        ALU_result = op1*op2;
          npc_reg = 0; end
        
      4'b0011: //load word 
        begin
          npc_reg = 0; end
      
       4'b0100: //store word
        begin 
          ALU_result = op1;
          npc_reg = 0;
        end 
     
      4'b0101://beq
        begin
          ALU_result = op1 - op2;
        if(op1==op2)
          begin 
            npc_reg = imm;
            jump_selector_reg = 1'b1;
          end
          else 
            npc_reg = 0;
        end
      4'b0110:
        begin
          ALU_result = op1 - op2;
        if(op1!=op2)
          begin
            npc_reg = imm; 
            jump_selector_reg = 1'b1;
            $display(npc_reg);
          end
          else 
            npc_reg = 0;
        end
     
        default: begin 
          ALU_result = op1 + op2;
          npc_reg = 0;
        end   
      endcase
     ldsti_reg = ldsti;
     regdesti_reg = regdesti;
     
            //$display("inside exe uu: npc is:%d ",npc_reg);
    end
endmodule