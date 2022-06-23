`timescale 100fs/100fs

module Choose3(
    ALUOutW,
    ReadDataW,
    MemtoRegW,
    ResultW
);

input MemtoRegW;
input [31:0] ALUOutW,ReadDataW;
output reg[31:0] ResultW;
initial begin
    ResultW = 0;
end

always @(*) begin
    if (MemtoRegW == 1)
        ResultW = ReadDataW;
    else
        ResultW = ALUOutW;
end

endmodule // Choose3