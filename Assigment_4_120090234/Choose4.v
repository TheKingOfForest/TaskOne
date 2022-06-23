`timescale 100fs/100fs

module Choose4(
    PCPlus4F,
    PCBranchM,
    PCSrcM,
    PC
);

input PCSrcM;
input [31:0] PCPlus4F,PCBranchM;
output reg[31:0] PC;
initial begin
  PC = 0;
end
always @(*) begin
    if (PCSrcM == 1)
        PC = PCBranchM;
    else
        PC = PCPlus4F;
end

endmodule // Choose3