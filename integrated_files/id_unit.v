module id_unit (
  input wire clkwire,
  input [15:0] regwire1, regwire2, regwire3, regwire4, regwire5, regwire6, regwire7, regwire8,
  input [19:0] current_instruction,
  output [15:0] reg_data_1_wire,reg_data_2_wire,
  output [3:0] instruction_4_bits,dest_reg_wire,memwire,
  output [7:0] instrwire
);
  reg [15:0] reg_data_1,reg_data_2,dest_reg,r1,r2,r3,r4,r5,r6,r7,r8;
  reg [3:0] opcode,mem_line_no;
  reg [19:0] instr;
  reg [7:0] instr_line_no, npc;


assign memwire=mem_line_no;
assign instruction_4_bits=opcode;
assign dest_reg_wire=dest_reg;
assign reg_data_1_wire=reg_data_1;
assign reg_data_2_wire=reg_data_2;
assign instrwire=instr_line_no;
  always@(posedge clkwire)
begin
  r1 = regwire1;
  r2 = regwire2;
  r3 = regwire3;
  r4 = regwire4;
  r5 = regwire5;
  r6 = regwire6;
  r7 = regwire7;
  r8 = regwire8;
  instr = current_instruction;
  
  opcode=instr[19:16];
  mem_line_no=instr[11:8];
  dest_reg=instr[15:12];
  //$display("%b",instr);
  instr_line_no=instr[7:0];
  //$display("%b",instr_line_no);
    //r-type
  if (instr[19:16]==4'b0000 || instr[19:16]==4'b0001 || instr[19:16]==4'b0010) 
      begin
        case(instr[11:8])
          4'b0000:
			    begin
              reg_data_1=r1;
          end
          4'b0001:
			begin
              reg_data_1=r2;
            end
          4'b0010:
			begin
              reg_data_1=r3;
            end
          4'b0011:
			begin
              reg_data_1=r4;
            end
          4'b0100:
			begin
              reg_data_1=r5;
            end
          4'b0101:
			begin
              reg_data_1=r6;
            end
          4'b0110:
			begin
              reg_data_1=r7;
            end
          4'b0111:
			begin
              reg_data_1=r8;
            end
        endcase
          case(instr[7:4])
          4'b0000:
			begin
              reg_data_2=r1;
            end
          4'b0001:
			begin
              reg_data_2=r2;
            end
          4'b0010:
			begin
              reg_data_2=r3;
            end
          4'b0011:
			begin
              reg_data_2=r4;
            end
          4'b0100:
			begin
              reg_data_2=r5;
            end
          4'b0101:
			begin
              reg_data_2=r6;
            end
          4'b0110:
			begin
              reg_data_2=r7;
            end
          4'b0111:
			begin
              reg_data_2=r8;
            end
          endcase
      end
    //beq and bne
  if (instr[19:16]==4'b0101 || instr[19:16]==4'b0110) 
      	begin
          case(instr[15:12])
          4'b0000:
			begin
              reg_data_1=r1;
            end
          4'b0001:
			begin
              reg_data_1=r2;
            end
          4'b0010:
			begin
              reg_data_1=r3;
            end
          4'b0011:
			begin
              reg_data_1=r4;
            end
          4'b0100:
			begin
              reg_data_1=r5;
            end
          4'b0101:
			begin
              reg_data_1=r6;
            end
          4'b0110:
			begin
              reg_data_1=r7;
            end
          4'b0111:
			begin
              reg_data_1=r8;
            end
          endcase
            case(instr[11:8])
          4'b0000:
			begin
              reg_data_2=r1;
            end
          4'b0001:
			begin
              reg_data_2=r2;
            end
          4'b0010:
			begin
              reg_data_2=r3;
            end
          4'b0011:
			begin
              reg_data_2=r4;
            end
          4'b0100:
			begin
              reg_data_2=r5;
            end
          4'b0101:
			begin
              reg_data_2=r6;
            end
          4'b0110:
			begin
              reg_data_2=r7;
            end
          4'b0111:
			begin
              reg_data_2=r8;
            end
         endcase
      end
      //lw 
      if (instr[19:16]==4'b0011) 
      	begin
          reg_data_1=instr[11:8];
          reg_data_2=instr[7:4];
        end
      //sw
      if (instr[19:16]==4'b0100) 
      	begin
          reg_data_1=instr[11:8];
          reg_data_2=instr[7:4];
          case(instr[15:12])
          4'b0000:
			begin
              reg_data_1=r1;
            end
          4'b0001:
			begin
              reg_data_1=r2;
            end
          4'b0010:
			begin
              reg_data_1=r3;
            end
          4'b0011:
			begin
              reg_data_1=r4;
            end
          4'b0100:
			begin
              reg_data_1=r5;
            end
          4'b0101:
			begin
              reg_data_1=r6;
            end
          4'b0110:
			begin
              reg_data_1=r7;
            end
          4'b0111:
			begin
              reg_data_1=r8;
            end
          endcase  
      end
      //stall
      if(instr[19:16]==4'b1111 || instr[19:16]==4'b1110) 
        begin
          reg_data_1=instr[11:8];
          reg_data_2=instr[7:4];
          
        end

  
end



    
endmodule