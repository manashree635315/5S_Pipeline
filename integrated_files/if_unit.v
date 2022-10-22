module if_unit(
    input wire clkwire,
    input wire jump_selector,
    input wire [7: 0] jump_address,
    output wire [19: 0] instructionwire,
    output wire [7: 0] npc
    );
reg [7: 0] pc;
reg [19:0] instructions_all [0: 99];
reg [19:0] curr_instruction;
integer file, line_num, a;
initial 
begin 
    file = $fopen("instructions.txt", "r");
    line_num = 0;
    while(! $feof(file))
    begin
        a = $fscanf(file, "%b", instructions_all[line_num]);
        line_num = line_num + 1;
    end
end
assign instructionwire = curr_instruction;
assign npc = pc;
always @(posedge clkwire)
begin
    if (jump_selector == 1)begin
        pc = jump_address;
    end
//$display("new instruction incoming!!");
$display("pc = %0d", pc);
curr_instruction = instructions_all[pc];
pc = pc + 1;
//$display("instruction in unit = %b", curr_instruction);
end
initial
pc = 8'b0;
endmodule