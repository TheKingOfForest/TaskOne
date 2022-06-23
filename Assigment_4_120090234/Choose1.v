`timescale 100fs/100fs

module Choose1(RD1E,RD2E,SaE,imme,RtE,RdE,PCPlus4E,A,B,WriteDataE,WriteRegE,PCBranchE,ALUSrcE,RegDstE,ShamtConE,ZeroExtendE);

input ALUSrcE,RegDstE,ShamtConE,ZeroExtendE;
input signed [31:0] RD1E,RD2E,imme;
input [4:0] RtE,RdE,SaE;
input [31:0] PCPlus4E;

output reg signed[31:0] A,B;
output reg [31:0] WriteDataE,PCBranchE;
output reg [4:0] WriteRegE;

reg signed [31:0] shamtnum;
reg signed [31:0] PCTmp;

initial begin
    A = 0;
    B = 0;
    WriteDataE = 0;
    PCBranchE = 0;
    WriteRegE = 0;
    shamtnum = 0;
    PCTmp = 0;
end
always @(*) begin
    shamtnum = {27'b0,SaE};
    if (ShamtConE == 1)     
        A = shamtnum;      
    else
        A = RD1E;
    if (ALUSrcE == 1)
        B = imme;
    else
        B = RD2E;
    if (ZeroExtendE==1)
        B = {16'b0,B[15:0]};
    WriteDataE = $unsigned(RD2E);
    if (RegDstE == 1)
        WriteRegE = RdE;
    else
        WriteRegE = RtE;
    PCTmp <= ($signed(PCPlus4E) + imme - 1);
    PCBranchE <= $unsigned(PCTmp);
    
end


endmodule