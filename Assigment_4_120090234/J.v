`timescale 100fs/100fs
// This module control the J part
module J(
    instr,
    PC1,
    JA,
    JR,
    PCC,
    JW
);

input [31:0] instr;
output reg[31:0] PC1;
output reg[1:0] PCC;
output reg[4:0] JA;
output reg JW,JR;




initial begin
  PC1 = 0;
  PCC = 0;
  JR = 0;
  JW = 0;
  JA = 0;
end

always @(*) begin
    if (instr[31:26] == 6'b000010) begin //j
        PC1 = {6'b000000,instr[25:0]};
        PCC = 2'b01;
        JR = 0;
        JW = 0;
    end
    else if (instr[31:26] == 6'b000011) begin //jal
        PC1 = {6'b000000,instr[25:0]};
        PCC = 2'b01;
        JA = 5'b11111;
        JR = 0;
        JW = 1;
    end
    else if (instr[31:26] == 6'b000000 && instr[5:0] == 6'b001000) begin //jr
        JR = 1;
        JW = 0;
        JA = instr[25:21];
        PCC = 2'b10;
    end
    else begin
        PCC = 2'b00;
        JR = 0;
        JW = 0;
    end
end

endmodule // 