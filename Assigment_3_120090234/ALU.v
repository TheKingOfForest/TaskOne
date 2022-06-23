module alu(instruction, regA,regB,result,flag);

    input[31:0] instruction, regA, regB;  //regA(00000) regB(00001)
    output reg[31:0] result;
    output reg[2:0] flag;    //flag[0] represents zero; flag[1] represents negative; flag[2] represents overflow
    
    reg[31:0] ri;
    reg signed[31:0] tmp;
    reg[5:0] opcode, funct;
    reg[4:0] rs, rt, rd, shamt;
    reg[15:0] imme;
    reg[0:0] carryout;
    // Begin simulate
    always @(*)
    begin
        opcode = instruction[31:26];
        rs = instruction[25:21];  //always regA(00000) if needed 
        rt = instruction[20:16];  //always regB(00001) if needed
        rd = instruction[15:11];
        shamt = instruction[10:6];
        funct = instruction[5:0];
        imme = instruction[15:0];
        flag = 3'b000;
        carryout = 1'b0;
        if (opcode == 6'b0 && funct == 6'b10_0000) // add
            begin
                {carryout[0],result} = regA + regB;
                if((regA[31] == 1'b1 && regB[31] == 1'b1 && result[31] == 1'b0) ||
                   (regA[31] == 1'b0 && regB[31] == 1'b0 && result[31] == 1'b1))
                    flag[2] = 1'b1;
                else
                    flag[2] = 1'b0;
            end
        else if(opcode == 6'b00_1000)  //addi
            begin
                ri = {{16{imme[15]}},imme};
                {carryout[0],result} = regA + ri;
                if((regA[31] == 1'b1 && ri[31] == 1'b1 && result[31] == 1'b0) ||
                   (regA[31] == 1'b0 && ri[31] == 1'b0 && result[31] == 1'b1))
                    flag[2] = 1'b1;
                else
                    flag[2] = 1'b0;
            end
        else if (opcode == 6'b0 && funct == 6'b10_0001) // addu
            begin
                {carryout[0],result} = regA + regB;
            end
        else if (opcode == 6'b00_1001) // addiu
            begin
                ri = {16'b0,imme};
                result = regA + ri;
            end
        else if (opcode == 6'b0 && funct == 6'b10_0010) // sub
            begin
                {carryout[0],result} = regA + (~regB) + 1;
                if((regA[31] == 1'b1 && regB[31] == 1'b0 && result[31] == 1'b0) ||
                   (regA[31] == 1'b0 && regB[31] == 1'b1 && result[31] == 1'b1))
                    flag[2] = 1'b1;
                else
                    flag[2] = 1'b0;
            end
        else if (opcode == 6'b0 && funct == 6'b10_0011) // subu
            begin
                {carryout[0],result} = regA + (~regB) + 1;
            end
        else if (opcode == 6'b0 && funct == 6'b10_0100) // and
            begin
                result = regA & regB;
            end
        else if (opcode == 6'b00_1100) // andi
            begin
                ri = {16'b0,imme};
                result = regA & ri;
            end
        else if (opcode == 6'b0 && funct == 6'b10_0111) //nor
            begin
                result = regA ~| regB;
            end
        else if (opcode == 6'b0 && funct == 6'b10_0101) //or
            begin
                result = regA | regB;
            end
        else if (opcode == 6'b00_1101) //ori
            begin
                ri = {16'b0,imme};
                result = regA | ri;
            end
        else if (opcode == 6'b0 && funct == 6'b10_0110) //xor
            begin
                result = regA ^ regB;
            end
        else if (opcode == 6'b00_1110) //xori
            begin
                ri = {16'b0,imme};
                result = regA ^ ri;
            end
        else if(opcode == 6'b00_0100)                   // beq
            begin
                {carryout[0], result} = regA + (~regB) + 1;
                if(result == 32'b0)
                    flag[0] = 1'b1;
            end
        else if(opcode == 6'b00_0101)                   // bne
            begin
                {carryout[0], result} = regA + (~regB) + 1;
                if(result == 32'b0)
                    flag[0] = 1'b1;
            end
        else if(opcode == 6'b0 && funct == 6'b10_1010) //slt
            begin
                if (regA[31] == 1'b1 && regB[31] == 1'b0) 
                    result = 32'h0000_0001;
                if (regA[31] == 1'b1 && regB[31] == 1'b0)
                    flag[1] = 1'b1;
                if(regA[31] == 1'b0 && regB[31] == 1'b1)
                    result = 32'h0000_0000;
                if(regA[31] == 1'b1 && regB[31] == 1'b1||regA[31] == 1'b0 && regB[31] == 1'b0)
                    result = regA + (~regB) + 1;
                if (result[31] == 1'b1)
                    flag[1] = 1'b1;
            end
        else if(opcode == 6'b00_1010) //slti
            begin
                ri = {{16{imme[15]}},imme};
                if (regA[31] == 1'b1 && ri[31] == 1'b0) 
                    result = 32'h0000_0001;
                if (regA[31] == 1'b1 && ri[31] == 1'b0)
                    flag[1] = 1'b1;
                if(regA[31] == 1'b0 && ri[31] == 1'b1)
                    result = 32'h0000_0000;
                if(regA[31] == 1'b1 && ri[31] == 1'b1||regA[31] == 1'b0 && ri[31] == 1'b0)
                    result = regA + (~ri) + 1;
                if (result[31] == 1'b1)
                    flag[1] = 1'b1;
            end
        else if(opcode == 6'b0 && funct == 6'b10_1011) //sltu
            begin
                if (regA < regB)
                    result = 32'h0000_0001;
                if (regA < regB)
                    flag[1] = 1'b1;
                if (regA >= regB)
                    result = 32'h0000_0000;
            end
        else if(opcode == 6'b00_1011) //sltiu
            begin
                ri = {16'b0, imme};
                if (regA < ri)
                    result = 32'h0000_0001;
                if (regA < ri)
                    flag[1] = 1'b1;
                if (regA >= ri)
                    result = 32'h0000_0000;
            end
        else if (opcode == 6'b10_0011) // lw
            begin
                ri = {{16{imme[15]}},imme};
                result = regA + ri;
            end
        else if (opcode == 6'b10_1011) // sw
            begin
                ri = {{16{imme[15]}},imme};
                result = regA + ri;
            end
        else if (opcode == 6'b0 && funct == 6'b0) //sll
            begin
              result = regB << shamt;
            end
        else if (opcode == 6'b0 && funct == 6'b00_0100) //sllv
            begin
              result = regB << regA[4:0];
            end
        else if (opcode == 6'b0 && funct == 6'b00_0010) // srl
            begin
              result = regB >> shamt;
            end
        else if (opcode == 6'b0 && funct == 6'b00_0110) //srlv
            begin
              result = regB >> regA[4:0];
            end
        else if (opcode == 6'b0 && funct == 6'b00_0111) //srav
            begin
              tmp = regB;  
              result = tmp >>> regA[4:0];
            end
        else if (opcode == 6'b0 && funct == 6'b00_0011) //sra
            begin
              tmp = regB;
              result = tmp >>> shamt;
            end
        end
endmodule