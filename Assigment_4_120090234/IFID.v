`timescale 100fs/100fs

module IF_ID(instr,PCPlus4F,PCPlus4D,Op,Funct,rs,rt,rd,sa,imm,CLK,RESET);

input [31:0] instr;
input [31:0] PCPlus4F;
input CLK,RESET;
output reg[5:0] Op, Funct;
output reg[4:0] rs,rt,rd,sa;
output reg signed[31:0] imm;
output reg[31:0] PCPlus4D;

initial begin
  PCPlus4D <= 0;
  rs <= 0;
  rt <= 0;
  rd <= 0;
  sa <= 0;
  imm <= 0;
  Op <= 0;
  Funct <= 0;
end

always @(posedge CLK) begin
if (RESET == 1) begin
  PCPlus4D <= 0;
  rs <= 0;
  rt <= 0;
  rd <= 0;
  sa <= 0;
  imm <= 0;
  Op <= 0;
  Funct <= 0;
end
else begin
  PCPlus4D <= PCPlus4F;
  Op <= instr[31:26];
  Funct <= instr[5:0];
  rs <= instr[25:21];
  rt <= instr[20:16];
  rd <= instr[15:11];
  sa <= instr[10:6];
  imm <= $signed({{16{instr[15]}},instr[15:0]});
end
end
endmodule