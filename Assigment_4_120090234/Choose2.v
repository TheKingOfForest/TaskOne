`timescale 100fs/100fs

module Choose2(
    PC,
    PC1,
    PC2,
    PCC,
    PCE
);

input[1:0] PCC; // choose which pc
input [31:0] PC,PC1,PC2; // three pc
output reg[31:0] PCE;

initial begin
  PCE = 0;
end

always @(*) begin
    if (PCC == 2'b00)
        PCE = PC;
    else if (PCC == 2'b01)
        PCE = PC1;
    else
        PCE = PC2;
end

endmodule // Choose