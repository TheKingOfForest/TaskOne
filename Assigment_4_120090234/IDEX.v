`timescale 100fs/100fs

module ID_EX(CLK, RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUControlD, ALUSrcD, RegDstD,ShamtConD,RegWriteE, MemtoRegE, MemWriteE, BranchE, ALUControlE, ALUSrcE,RegDstE ,RD1, RD2, rt, rd, sa, SaE, RD1E,RD2E, signnum,imme,PCPlus4D,PCPlus4E,ShamtConE,RtE,RdE,ZeroExtendD,ZeroExtendE,RESET);

input CLK,RESET;
input RegWriteD,MemtoRegD,MemWriteD,BranchD,ALUSrcD,RegDstD,ShamtConD,ZeroExtendD;
input [3:0] ALUControlD;
input signed[31:0] RD1,RD2,signnum;
input [31:0] PCPlus4D;
input [4:0] rt,rd,sa;
output reg RegWriteE,MemtoRegE,MemWriteE,BranchE,ALUSrcE,RegDstE,ShamtConE,ZeroExtendE;
output reg [3:0] ALUControlE;
output reg signed[31:0] RD1E,RD2E,imme;
output reg [31:0] PCPlus4E;
output reg [4:0] RtE,RdE,SaE;


initial begin
    RegWriteE<=0;
    MemtoRegE<=0;
    MemWriteE<=0;
    BranchE<=0;
    ALUControlE<=4'b0000;
    ALUSrcE <= 0;
    RegDstE <= 0;
    ShamtConE <= 0;
    RD1E <= 0;
    RD2E<=0;
    imme<=0;
    PCPlus4E<=0;
    RtE<=0;
    RdE<=0;
    SaE<=0;
    ZeroExtendE<=0;
end

always @(posedge CLK) begin
if (RESET == 1) begin
    RegWriteE<=0;
    MemtoRegE<=0;
    MemWriteE<=0;
    BranchE<=0;
    ALUControlE<=4'b0000;
    ALUSrcE <= 0;
    RegDstE <= 0;
    ShamtConE <= 0;
    RD1E <= 0;
    RD2E<=0;
    imme<=0;
    PCPlus4E<=0;
    RtE<=0;
    RdE<=0;
    SaE<=0;
    ZeroExtendE<=0;
end
else begin
    RegWriteE<=RegWriteD;
    MemtoRegE<=MemtoRegD;
    MemWriteE<=MemWriteD;
    BranchE<=BranchD;
    ALUControlE<=ALUControlD;
    ALUSrcE <= ALUSrcD;
    RegDstE <= RegDstD;
    ShamtConE <= ShamtConD;
    RD1E <= RD1;
    RD2E<=RD2;
    imme<=signnum;
    PCPlus4E<=PCPlus4D;
    RtE<=rt;
    RdE<=rd;
    SaE<=sa;
    ZeroExtendE<=ZeroExtendD;
end
end
endmodule