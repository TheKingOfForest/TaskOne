`timescale 100fs/100fs

module MEM_WB(CLK, RegWriteM, MemtoRegM, RegWriteW, ALUOutM, DATA, WriteRegM, WriteRegW,ALUOutW,ReadDataW,MemtoRegW);

input CLK;
input [4:0] WriteRegM;
input [31:0] DATA;
input [31:0] ALUOutM;
input RegWriteM, MemtoRegM;
output reg RegWriteW,MemtoRegW;
output reg [31:0] ALUOutW,ReadDataW;
output reg[4:0] WriteRegW;

initial begin
  RegWriteW <= 0;
  ALUOutW<=0;
  ReadDataW<=0;
  WriteRegW <= 0;
  MemtoRegW <= 0;
end

always @(posedge CLK) begin
    RegWriteW <= RegWriteM;
    ALUOutW<=ALUOutM;
    ReadDataW<=DATA;
    WriteRegW <= WriteRegM;
    MemtoRegW <= MemtoRegM;
end

endmodule