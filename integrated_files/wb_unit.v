module write_back(
input wire clkwire, 
input writeToReg,
input wire [15 : 0] writeData,
input wire [3 : 0] regNos,
input wire [15 : 0] reg1_in,
input wire [15 : 0] reg2_in,
input wire [15 : 0] reg3_in,
input wire [15 : 0] reg4_in,
input wire [15 : 0] reg5_in,
input wire [15 : 0] reg6_in,
input wire [15 : 0] reg7_in,
input wire [15 : 0] reg8_in,

output wire [15 : 0] reg1_out,
output wire [15 : 0] reg2_out,
output wire [15 : 0] reg3_out,
output wire [15 : 0] reg4_out,
output wire [15 : 0] reg5_out,
output wire [15 : 0] reg6_out,
output wire [15 : 0] reg7_out,
output wire [15 : 0] reg8_out
);

reg [3 : 0] ADD = 4'b0000;
reg [3 : 0] SUB = 4'b0001;
reg [3 : 0] MUL = 4'b0010;
reg [3 : 0] LW =  4'b0011;
reg [3 : 0] SW =  4'b0100;
reg [3 : 0] BEQ = 4'b0101;
reg [3 : 0] BNE = 4'b0110;

reg [15: 0] reg1_in_data;
reg [15: 0] reg2_in_data;
reg [15: 0] reg3_in_data;
reg [15: 0] reg4_in_data;
reg [15: 0] reg5_in_data;
reg [15: 0] reg6_in_data;
reg [15: 0] reg7_in_data;
reg [15: 0] reg8_in_data;



assign reg1_out = reg1_in_data;
assign reg2_out = reg2_in_data;
assign reg3_out = reg3_in_data;
assign reg4_out = reg4_in_data;
assign reg5_out = reg5_in_data;
assign reg6_out = reg6_in_data;
assign reg7_out = reg7_in_data;
assign reg8_out = reg8_in_data;

initial
begin
    reg1_in_data = 16'b0000000000000000;
    reg2_in_data = 16'b0000000000000000;
    reg3_in_data = 16'b0000000000000000;
    reg4_in_data = 16'b0000000000000000;
    reg5_in_data = 16'b0000000000000000;
    reg6_in_data = 16'b0000000000000000;
    reg7_in_data = 16'b0000000000000000;
    reg8_in_data = 16'b0000000000000000;
end


always @(posedge clkwire)

begin

    reg1_in_data = reg1_in;
    reg2_in_data = reg2_in;
    reg3_in_data = reg3_in;
    reg4_in_data = reg4_in;
    reg5_in_data = reg5_in;
    reg6_in_data = reg6_in;
    reg7_in_data = reg7_in;
    reg8_in_data = reg8_in;

    if(writeToReg == 1'b1)
        begin
            $display("data received by writeback unit is ", writeData);
            if(regNos == 4'b0000)
            begin 
                reg1_in_data <= writeData;
            end

            else if(regNos == 4'b0001)
            begin 
                reg2_in_data <=writeData;
            end

            else if(regNos == 4'b0010)
            begin 
                reg3_in_data <=writeData;
            end

             else if(regNos == 4'b0011)
            begin 
                reg4_in_data <=writeData;
            end

             else if(regNos == 4'b0100)
            begin 
                reg5_in_data <=writeData;
            end

             else if(regNos == 4'b0101)
            begin 
                reg6_in_data <=writeData;
            end

             else if(regNos == 4'b0110)
            begin 
                reg7_in_data <=writeData;
            end

             else if(regNos == 4'b0111)
            begin 
                reg8_in_data <=writeData;
            end

        end
        $display("reg state in wrtieback unit is : ",reg1_in_data, reg2_in_data, reg3_in_data, reg4_in_data, reg5_in_data, reg6_in_data, reg7_in_data, reg8_in_data);
end
endmodule
