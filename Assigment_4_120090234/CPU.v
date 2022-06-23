`include "ALU.v"
`include "Clock.v"
`include "ControlUnit.v"
`include "EXMEM.v"
`include "IDEX.v"
`include "IFID.v"
`include "InstructionRAM.v"
`include "MainMemory.v"
`include "MEMWB.v"
`include "RegisterFile.v"
`include "IF.v"
`include "PCPlus.v"
`include "Choose1.v"
`include "Choose3.v"
`include "Choose4.v"
`include "Choose2.v"
`include "J.v"
`timescale 100fs/100fs

module CPU;

wire CLK;
//wire CLKEN;
clock clock_1(
    .ENABLE    (1'b1),
    .CLK       (CLK)
);

//PC block
wire [31:0] PCBranchM;
wire [31:0] PCPlus4F;
wire [31:0] PCF;
wire [31:0] PC,PC1,PC2,PCE,DATAJ;
wire [1:0] PCC;
wire [4:0] JA;
wire PCSrcM,JW,JR;

IF IF_1(
    .CLK        (CLK),
    .PCE         (PCE),
    .PCF        (PCF)
);

J J_1(
    .instr  (instr),
    .PC1    (PC1),
    .PCC    (PCC),
    .JA     (JA),
    .JR     (JR),
    .JW     (JW)
);

Choose2 Choose2_1(
    .PC     (PC),
    .PC1    (PC1),
    .PC2    (PC2),
    .PCC    (PCC),
    .PCE    (PCE)
);

PCPlus PCPlus_1(
    .PCF    (PCF),
    .PCPlus4F   (PCPlus4F)
);

Choose4 Choose4_1(
    .PCSrcM     (PCSrcM),
    .PC         (PC),
    .PCPlus4F   (PCPlus4F),
    .PCBranchM  (PCBranchM)
);
//InstructionRAM
wire [31:0] instr;

InstructionRAM InstructionRAM_1(
    .RESET      (1'b0),
    .ENABLE     (1'b1),
    .FETCH_ADDRESS  (PCF),
    .DATA       (instr)
);

//DE part
wire[5:0] Op, Funct;
wire[4:0] rs,rt,rd,sa;
wire signed[31:0] imm;
wire[31:0] PCPlus4D;
wire RESET;

assign RESET = PCSrcM;

IF_ID IF_ID_1(
    .instr      (instr),
    .CLK        (CLK),
    .PCPlus4F   (PCPlus4F),
    .Op         (Op),
    .Funct      (Funct),
    .rs         (rs),
    .rt         (rt),
    .rd         (rd),
    .sa         (sa),
    .imm        (imm),
    .PCPlus4D   (PCPlus4D),
    .RESET      (RESET)
);

// ControlUnit
wire RegWriteD, MemtoRegD, MemWriteD, BranchD, ALUSrcD, RegDstD,ShamtConD,ZeroExtendD;
wire[3:0] ALUControlD;

ControlUnit Con_1(
    .Op         (Op),
    .Funct      (Funct),
    .RegWriteD  (RegWriteD),
    .MemtoRegD  (MemtoRegD),
    .MemWriteD  (MemWriteD),
    .BranchD    (BranchD),
    .ALUSrcD    (ALUSrcD),
    .RegDstD    (RegDstD),
    .ShamtConD  (ShamtConD),
    .ALUControlD    (ALUControlD),
    .ZeroExtendD    (ZeroExtendD)
);

// Register File
wire RegWriteW;
wire[4:0] WriteRegW;
wire [31:0] ResultW;
wire signed[31:0] RD1,RD2;

RegisterFile RF_1(
    .A1     (rs),
    .A2     (rt),
    .A3     (WriteRegW),
    .WE3    (RegWriteW),
    .WD3    (ResultW),
    .RD1    (RD1),
    .RD2    (RD2),
    .JA     (JA),
    .PC2    (PC2),
    .JR     (JR),
    .JW     (JW),
    .PCF    (PCF)
);

//IDEX
wire[3:0] ALUControlE;
wire RegWriteE, MemtoRegE, MemWriteE, BranchE,ALUSrcE,RegDstE,ShamtConE,ZeroExtendE;
wire [4:0] RtE,RdE,SaE;
wire signed[31:0] RD1E,RD2E,imme;
wire [31:0] PCPlus4E;
wire signed[31:0] A,B;
wire[4:0] WriteRegE;
wire[31:0] WriteDataE;
wire[31:0] PCBranchE;

ID_EX IE(
    .CLK        (CLK),
    .signnum    (imm),
    .rt         (rt),
    .rd         (rd),
    .sa         (sa),
    .ALUControlD    (ALUControlD),
    .RD1        (RD1),
    .RD2        (RD2),
    .RegWriteD  (RegWriteD),
    .MemtoRegD  (MemtoRegD),
    .MemWriteD  (MemWriteD),
    .BranchD    (BranchD),
    .ALUSrcD    (ALUSrcD),
    .RegDstD    (RegDstD),
    .ShamtConD  (ShamtConD),
    .PCPlus4D   (PCPlus4D),
    .RegWriteE  (RegWriteE),
    .MemtoRegE  (MemtoRegE),
    .MemWriteE  (MemWriteE),
    .BranchE    (BranchE),
    .ALUControlE    (ALUControlE),
    .ALUSrcE    (ALUSrcE),
    .RegDstE    (RegDstE),
    .ShamtConE  (ShamtConE),
    .RD1E       (RD1E),
    .RD2E       (RD2E),
    .imme       (imme),
    .PCPlus4E   (PCPlus4E),
    .RtE        (RtE),
    .RdE        (RdE),
    .SaE        (SaE),
    .ZeroExtendD    (ZeroExtendD),
    .ZeroExtendE    (ZeroExtendE),
    .RESET      (RESET)
);

Choose1 Choose1_1(
    .ALUSrcE    (ALUSrcE),
    .RegDstE    (RegDstE),
    .ShamtConE  (ShamtConE),
    .RD1E       (RD1E),
    .RD2E       (RD2E),
    .imme       (imme),
    .RtE        (RtE),
    .RdE        (RdE),
    .SaE        (SaE),
    .PCPlus4E   (PCPlus4E),
    .A          (A),
    .B          (B),
    .WriteDataE (WriteDataE),
    .PCBranchE  (PCBranchE),
    .WriteRegE  (WriteRegE),
    .ZeroExtendE    (ZeroExtendE)
);

//ALu
wire signed[31:0] C;
wire zero;

ALU ALU_1(
    .A      (A),
    .B      (B),
    .ALUcontrol     (ALUControlE),
    .zero   (zero),
    .C      (C)
);

//EXMEM
wire RegWriteM, MemtoRegM, MemWriteM;
wire[31:0] ALUOutM;
wire[4:0] WriteRegM;
wire[31:0] WriteDataM;

EX_MEM EM(
    .CLK        (CLK),
    .RegWriteE  (RegWriteE),
    .MemtoRegE  (MemtoRegE),
    .MemWriteE  (MemWriteE),
    .BranchE    (BranchE),
    .Zero       (zero),
    .C          (C),
    .WriteRegE  (WriteRegE),
    .WriteDataE (WriteDataE),
    .PCBranchE  (PCBranchE),
    .RegWriteM  (RegWriteM),
    .MemtoRegM  (MemtoRegM),
    .MemWriteM  (MemWriteM),
    .ALUOutM    (ALUOutM),   
    .PCSrcM     (PCSrcM),
    .WriteRegM  (WriteRegM),
    .WriteDataM (WriteDataM),
    .PCBranchM  (PCBranchM),
    .RESET      (RESET)
);

//Main Memory
wire[64:0] EDIT_SERIAL;
wire[31:0] DATA;

assign EDIT_SERIAL = {MemWriteM,ALUOutM,WriteDataM};

MainMemory MainMemory_1(
    .CLOCK      (CLK),
    .RESET      (1'b0),
    .ENABLE     (1'b1),
    .FETCH_ADDRESS  (ALUOutM),
    .DATA       (DATA),
    .EDIT_SERIAL    (EDIT_SERIAL)
);

//MEMWB

wire [31:0] ALUOutW,ReadDataW;
wire MemtoRegW;

MEM_WB MW(
    .CLK        (CLK),
    .DATA       (DATA),
    .ALUOutW    (ALUOutW),
    .ReadDataW  (ReadDataW),
    .MemtoRegW  (MemtoRegW),
    .ALUOutM    (ALUOutM),
    .RegWriteM  (RegWriteM),
    .MemtoRegM  (MemtoRegM),
    .RegWriteW  (RegWriteW),
    .WriteRegW  (WriteRegW),
    .WriteRegM  (WriteRegM)
);

Choose3 Choose3_1(
    .MemtoRegW  (MemtoRegW),
    .ALUOutW    (ALUOutW),
    .ReadDataW  (ReadDataW),
    .ResultW    (ResultW)
);

integer num;

integer fd;
initial begin
    fd = $fopen("output.txt", "w");
end


always @(negedge CLK) begin

    #900; 
    if (instr == 32'b1111_1111_1111_1111_1111_1111_1111_1111)
    #20000   
    begin
        num = 0;
        while(num < 2048)
        begin
            $fdisplay(fd, "%b", MainMemory_1.DATA_RAM[num]);
            num = num + 4;
        end
        $finish;
    end
end

endmodule // CPU