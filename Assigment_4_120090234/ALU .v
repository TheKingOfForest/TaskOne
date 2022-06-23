`timescale 100fs/100fs

module ALU(A,B,ALUcontrol,zero,C);

input signed[31:0] A,B;
input [3:0] ALUcontrol;
output reg zero;
output reg signed[31:0] C;

initial begin
  zero = 0;
  C = 0;
end

always @(*) begin
  case (ALUcontrol)
        4'b0000: // and 
        begin
            C=A&B;
        end
        4'b0001: // or 
        begin
            C=A|B;
        end
        4'b0010: // add
        begin
            C=A+B;
        end
        4'b0110: // sub 
        begin
            C=A-B;
        end
        4'b0111: // slt
        begin
            C= A < B ? 32'h0000_0001 : 32'h0000_0000;
        end
        4'b1100: // nor
        begin
            C=~(A | B);
        end
        4'b0011: // xor 
        begin
            C=A^B;
        end
        4'b0100: // sll or sllv
        begin
            C=B<<A[4:0];
        end
        4'b0101: // srl or srlv
        begin
            C=B>>A[4:0];
        end
        4'b1000: // sra or srav
        begin
            C=B>>>A[4:0];
        end
        4'b1001: // beq
        begin
            C= A == B ? 32'h0000_0001 : 32'h0000_0000;
            zero = A == B ? 1 : 0;
        end
        4'b1010: // bne
        begin
            C= A != B ? 32'h0000_0001 : 32'h0000_0000;
            zero = A != B ? 1 : 0;
        end
  endcase
end
endmodule