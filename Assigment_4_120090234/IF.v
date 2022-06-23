`timescale 100fs/100fs

module IF(CLK,PCE,PCF);

input CLK,WritePC;
input [31:0] PCE;
output reg[31:0] PCF;

initial begin
  PCF <= 0;
end

always @(posedge CLK) begin
    
      PCF <= PCE;
end

endmodule