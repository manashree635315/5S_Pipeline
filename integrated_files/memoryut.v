// `include "memory.txt"
// Code your design here
module memory_unit(
    input wire clkwire, //clock
    // input /pc,
    input wire [3:0] registernum,
    input wire [3:0] instruction, //opcode
    input wire [15:0] aluoutput, //data to write or output of r type instructions
    input [3:0] linenum, //line number to write data at
    output wire [15:0] writedata, //data from memory extracted using load instruction
    output wire [3:0] regnum,
    output wire [3:0] opcode_out,
    output wire checkbool //whether to write to register or not
);
    reg[15:0] Mem[0:15];
    reg[15:0] val;
    reg checkboolreg;
    integer i;
    reg [3:0] regno;
    reg [3:0] inst_pass;
    integer fd,a;
    assign regnum=regno;
    assign checkbool=checkboolreg;
    assign writedata=val;
    assign opcode_out=inst_pass;
  initial
    begin
        i=0;
        //checkbool=1'b0;
        fd=$fopen("mem.txt", "r");
        while(! ($feof(fd)))
        begin
            a = $fscanf(fd ,"%b", Mem[i]);
            //$display("%b", Mem[i]);
            i = i+1;   
        end
        // $display("bleh");
    end

always @(posedge clkwire) begin
    regno=registernum;
    inst_pass=instruction;
    // checkboolreg = 1'b0;
    if(instruction == 4'b0011) //load
        begin
            // $display("jjj");
            val=Mem[linenum-1];
            checkboolreg=1'b1;
            //$display("load:",val);
        end
    else if(instruction == 4'b0100) //store
        begin      
            // $display("hll");
            checkboolreg = 1'b0;
            val=0;
            fd=$fopen("mem.txt", "w");
            // $fdisplay(fd,"Value displayed with $fdisplay");
            for (i=0; i<=14; i=i+1)
            begin
                if(i==(linenum-1)) $fdisplay(fd,"%b", aluoutput);
                else $fdisplay(fd,"%b", Mem[i]); 
            end
            if(linenum!=(i+1)) $fwrite(fd, "%b",Mem[i]);
            else $fwrite(fd, "%b", aluoutput);
            // $display("store:",Mem[linenum-1]);
        $fclose(fd);
        end
    else if(instruction==4'b0000||instruction==4'b0001||instruction==4'b0010)
        begin 
            val=aluoutput;
            checkboolreg=1'b1;
            // $display("r-type:",val);
        end
    else checkboolreg = 1'b0;
    // $display("checkwdata in memory unit is :", checkbool);
end
endmodule
