`timescale 100fs/100fs

module PCPlus(
    PCF,
    PCPlus4F
);

input [31:0] PCF;
output reg [31:0] PCPlus4F;

initial begin
  PCPlus4F = 0;
end

always @(PCF) begin
    PCPlus4F = PCF + 1;
end
endmodule