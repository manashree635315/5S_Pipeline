# CSN 221 course project: a 5-stage Pipelined processor in Verilog.
# IIT Roorkee CSE
- Instruction Memory for 20-bit instructions consisting of arithmetic (ADD, SUBTRACT, MULTIPLY), branch (BRANCH NOT EQUAL, BRANCH ON EQUAL), and memory-access (LOAD, STORE) instructions.
- 16 16-bit Data Memory locations.
- 8 16-bit registers. 
- Stalling is implemented to resolve any data hazards. 

## 5 stages of the pipeline:
1. Instruction Fetch (IF)
2. Instruction Decode (ID)
3. Execution unit (EX)
4. Memory Access (MEM)
5. Writeback (WB)

### Instruction Opcodes:
- ADD = "0000";
- SUB = "0001";
- MUL = "0010";
- LW = "0011";
- SW = "0100";
- BEQ = "0101";
- BNE = "0110";
- Stall instruction: 11111111111111111111
- Halt instruction: 11100000000000000000

### Sample instructions: 
- Add instruction: `ADD R3 R2 R1` = 00000010000100000000
- Sub instruction: `SUB R3 R2 R1` = 00010010000100000000
- Mul instruction: `MUL R3 R2 R1` = 00100010000100000000
- Load instruction: `LW R5 9` = 00110100000010010000
- Store instruction: `SW R6 11` = 01000101000010110000
- Branch on equal instruction: `BEQ R2 R3 10` = 01010001001000001010 
- Branch not equal instruction: `BNE R4 R3 10` = 01100011001000001010 
	
## Group members: 
- Neha Gujar 21114039
- Manan Garg 21114056 
- Manashree Kalode 21114057 
- Nishita Singh 21114068
- Raiwat Bapat 21114078 
- Sanidhya Bhatia 21114090
