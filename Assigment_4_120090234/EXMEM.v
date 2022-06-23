`timescale 100fs/100fs

module EX_MEM(CLK, RegWriteE, MemtoRegE, MemWriteE, BranchE, RegWriteM, MemtoRegM, MemWriteM, PCSrcM, Zero, C, ALUOutM, WriteDataE, WriteDataM, WriteRegE, WriteRegM, PCBranchE,PCBranchM,RESET);

input CLK,RESET;
input [4:0] WriteRegE;
input [31:0] PCBranchE,WriteDataE;
input signed[31:0] C;
input RegWriteE, MemtoRegE, MemWriteE, BranchE, Zero;
output reg RegWriteM, MemtoRegM, MemWriteM, PCSrcM;
output reg[31:0] ALUOutM;
output reg[4:0] WriteRegM;
output reg[31:0] PCBranchM,WriteDataM;

initial begin
    RegWriteM<=0;
    MemtoRegM<=0;
    MemWriteM<=0;
    PCSrcM<=0;
    ALUOutM<=0;
    WriteDataM <= 0;
    WriteRegM <= 0;
    PCBranchM <= 0;
end

always @(posedge CLK) begin
if (RESET == 1) begin
    RegWriteM<=0;
    MemtoRegM<=0;
    MemWriteM<=0;
    PCSrcM<=0;
    ALUOutM<=0;
    WriteDataM <= 0;
    WriteRegM <= 0;
    PCBranchM <= 0;
end
else begin
    RegWriteM <= RegWriteE;
    MemtoRegM <= MemtoRegE;
    MemWriteM <= MemWriteE;
    PCSrcM <= BranchE & Zero;
    ALUOutM <= $unsigned(C);
    WriteDataM <= WriteDataE;
    WriteRegM <= WriteRegE;
    PCBranchM <= PCBranchE;
end
end

endmodule