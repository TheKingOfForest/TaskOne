`timescale 100fs/100fs

module ControlUnit(Op, Funct, RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUControlD, ALUSrcD, RegDstD,ShamtConD,ZeroExtendD,ENABLED);

input [5:0] Op, Funct;
output reg RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUSrcD, RegDstD,ShamtConD,ZeroExtendD,ENABLED;
output reg[3:0] ALUControlD;

initial begin
        RegWriteD=0;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0000;
        ALUSrcD=0;
        RegDstD=0;
        ShamtConD=0;
        ZeroExtendD=0;
        ENABLED = 0;
end

always @(Op, Funct) begin
    if ((Op==6'h0 && Funct == 6'h20)||(Op==6'h0 && Funct==6'h21)) // add or addu
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0010;
        ALUSrcD=0;
        RegDstD=1;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h8 || Op==6'h9) // addi or addiu
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0010;
        ALUSrcD=1;
        RegDstD=0;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if ((Op==6'h0 && Funct==6'h22)||(Op==6'h0 && Funct==6'h23)) // sub or subu
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0110;
        ALUSrcD=0;
        RegDstD=1;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h0 && Funct==6'h24) // &&
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0000;
        ALUSrcD=0;
        RegDstD=1;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'hc) // &&i
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0000;
        ALUSrcD=1;
        RegDstD =0;
        ShamtConD=0;
        ZeroExtendD=1;
    end
    else if (Op==6'h0 && Funct==6'h27) // nor
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b1100;
        ALUSrcD=0;
        RegDstD =1;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h0 && Funct==6'h25) // or
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0001;
        ALUSrcD=0;
        RegDstD =1;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'hd) // ori
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0001;
        ALUSrcD=1;
        RegDstD =0;
        ShamtConD=0;
        ZeroExtendD=1;
    end
    else if (Op==6'h0 && Funct==6'h26) // xor
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0011;
        ALUSrcD=0;
        RegDstD =1;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'he) // xori
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0011;
        ALUSrcD=1;
        RegDstD =0;
        ShamtConD=0;
        ZeroExtendD=1;
    end
    else if (Op==6'h0 && Funct==6'h0) // sll
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0100;
        ALUSrcD=0;
        RegDstD=1;
        ShamtConD=1;
        ZeroExtendD=0;
    end
    else if (Op==6'h0 && Funct==6'h4) // sllv
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0100;
        ALUSrcD=0;
        RegDstD=1;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h0 && Funct==6'h3) // sra
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b1000;
        ALUSrcD=0;
        RegDstD=1;
        ShamtConD=1;
        ZeroExtendD=0;
    end
    else if (Op==6'h0 && Funct==6'h7) // srav
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b1000;
        ALUSrcD=0;
        RegDstD=1;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h0 && Funct==6'h2) // srl
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0101;
        ALUSrcD=0;
        RegDstD=1;
        ShamtConD=1;
        ZeroExtendD=0;
    end
    else if (Op==6'h0 && Funct==6'h6) // srlv
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0101;
        ALUSrcD=0;
        RegDstD=1;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h4) // beq
    begin
        // $display("beq");
        RegWriteD=0;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=1;
        ALUControlD=4'b1001;
        ALUSrcD=0;
        RegDstD=0;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h5) // bne
    begin
        RegWriteD=0;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=1;
        ALUControlD=4'b1010;
        ALUSrcD=0;
        RegDstD=0;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h0 && Funct==6'h2a) // slt
    begin
        RegWriteD=1;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0111;
        ALUSrcD=0;
        RegDstD=1;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h23) // lw
    begin
        RegWriteD=1;
        MemtoRegD=1;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b0010;
        ALUSrcD=1;
        RegDstD=0;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h2b) // sw
    begin
        RegWriteD=0;
        MemtoRegD=0;
        MemWriteD=1;
        BranchD=0;
        ALUControlD=4'b0010;
        ALUSrcD=1;
        RegDstD=0;
        ShamtConD=0;
        ZeroExtendD=0;
    end
    else if (Op==6'h2) // j
    begin
        RegWriteD=0;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b1101;
        ALUSrcD=0;
        ShamtConD=0;
        ZeroExtendD=0;
        RegDstD=0;
    end
    else if (Op==6'h3) // jal
    begin
        RegWriteD=0;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b1101;
        ALUSrcD=0;
        ShamtConD=0;
        ZeroExtendD=0;
        RegDstD =0;
    end
    else if (Op==6'h0 && Funct==6'h8) // jr
    begin
        RegWriteD=0;
        MemtoRegD=0;
        MemWriteD=0;
        BranchD=0;
        ALUControlD=4'b1110;
        ALUSrcD=0;
        ShamtConD=0;
        ZeroExtendD=0;
        RegDstD =0;
    end
end

endmodule