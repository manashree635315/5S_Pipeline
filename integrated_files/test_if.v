`include "if_unit.v"

module if_test;
wire clkwire;
wire [19: 0] ciwire;
wire [7: 0] jump_address_wire;
wire jump_selector_wire;
wire [7: 0] npcwire;
reg clk, npc, jump_selector;
reg [7: 0] jump_address;
assign clkwire = clk;
assign jump_address_wire = jump_address;
assign jump_selector_wire = jump_selector;
always #5
begin
clk = ~clk;
if (npcwire == 5) begin
    jump_address = 8'd12;
    jump_selector = 1;
end
if (npcwire == 13) begin
    jump_selector = 0;
end
end
always @(posedge clk)
begin
$display("instruction in main = %b", ciwire);
$display("npc = %0d", npcwire);
end
if_unit mytest(clkwire, jump_selector_wire, jump_address_wire, ciwire, npcwire);
initial
begin
clk = 1'b0;
jump_address = 8'b0;
jump_selector = 1'b0;
#200 $finish;
end
endmodule