module Decoder(
    input logic [31:0] Instruction,
    output logic [4:0] Rs1,
    output logic [4:0] Rs2,
    output logic [4:0] Rd,
    output logic [6:0] Funct7,
    output logic RegWe,
    output logic MemWe,
    output logic Flush,
    output logic Stall,
    output logic SCallFlag,
    output logic SBreakFlag,
    output logic [2:0] Funct3,
    output logic [6:0] OpCode,
    output logic [3:0] ALUSelect,
    output logic [3:0] ByteEnable,
    output logic [1:0] WBSelect, //00 = ALU, 01 = Memory, 10 = PC, 11 = Counter
    output logic BranchInst,
    output logic ALUSrc //1 = imm, 0 = reg
    );

    assign OpCode = Instruction[6:0];
    assign Funct3 = Instruction[14:12];
    assign Funct7 = Instruction[31:25];
    assign Rd = Instruction[11:7];
    assign Rs1 = Instruction[19:15];
    assign Rs2 = Instruction[24:20];

    always_comb begin
        RegWe = 0;
        Flush = 0;
        WBSelect = 2'b00;
        SCallFlag = 0;
        SBreakFlag = 0;
        MemWe = 0;
        BranchInst = 0;
        Stall = 0;
        ALUSrc = 0;
        ALUSelect = 4'b0000;
        ByteEnable = 4'b0000;
        
        //U-instructions

        //AUIPC
        if(OpCode == 7'b0010111) begin
           RegWe = 1;
           ALUSrc = 1;
           WBSelect = 2'b10;
        end

        //LUI
        else if(OpCode == 7'b0110111) begin
            RegWe = 1;
            MemWe = 0;
            ALUSrc = 1;
        end
        
        //J-instructions

        //Jal
        else if (OpCode == 7'b1101111) begin
            RegWe = 1;
            ALUSrc = 1;
            WBSelect = 2'b10;
        end

        //Jalr
        else if(OpCode == 7'b1100111 && Funct3 == 3'b000) begin
            RegWe = 1;
            ALUSrc = 1;
            WBSelect = 2'b10;
        end

        //BEQ
        else if(OpCode == 7'b1100011 && Funct3 == 3'b000) begin
            BranchInst = 1;
            ALUSrc = 1;
        end

        //BNE
        else if(OpCode == 7'b1100011 && Funct3 == 3'b001) begin
            BranchInst = 1;
            ALUSrc = 1;
        end

        //BLT
        else if(OpCode == 7'b1100011 && Funct3 == 3'b100) begin
            RegWe = 1;
            ALUSrc = 1;
        end

        //BGE
        else if(OpCode == 7'b1100011 && Funct3 == 3'b101) begin
            BranchInst = 1;
            ALUSrc = 1;
        end

        //BLTU
        else if(OpCode == 7'b1100011 && Funct3 == 3'b110) begin
            BranchInst = 1;
            ALUSrc = 1;
        end

        //BGEU
        else if(OpCode == 7'b1100011 && Funct3 == 3'b111) begin
            BranchInst = 1;
            ALUSrc = 1;
        end

        //S instructions

        //SB
        else if(OpCode == 7'b0100011 && Funct3 == 3'b000) begin
            MemWe = 1;
            ByteEnable = 4'b0001;
            ALUSrc = 1;
        end

        //SH
        else if(OpCode == 7'b0100011 && Funct3 == 3'b001) begin
            MemWe = 1;
            ByteEnable = 4'b0011;
            ALUSrc = 1;
        end

        //SW
        else if(OpCode == 7'b0100011 && Funct3 == 3'b010) begin
            MemWe = 1;
            ByteEnable = 4'b1111;
            ALUSrc = 1;
        end

        //I Instructions

        //LB
        else if(OpCode == 7'b0000011 && Funct3 == 3'b000) begin
            RegWe = 1;
            ALUSrc = 1;
            WBSelect = 2'b01;
        end

        //LH
        else if(OpCode == 7'b0000011 && Funct3 == 3'b001) begin
            RegWe = 1;
            ALUSrc = 1;
            WBSelect = 2'b01;
        end

        //LW
        else if(OpCode == 7'b0000011 && Funct3 == 3'b010) begin
            RegWe = 1;
            ALUSrc = 1;
            WBSelect = 2'b01;
        end

        //LBU
        else if(OpCode == 7'b0000011 && Funct3 == 3'b100) begin
            RegWe = 1;
            ALUSrc = 1;
            WBSelect = 2'b01;
        end

        //LHU
        else if(OpCode == 7'b0000011 && Funct3 == 3'b101) begin
            RegWe = 1;
            ALUSrc = 1;
            WBSelect = 2'b01;
        end

        //ADDI
        else if(OpCode == 7'b0010011 && Funct3 == 3'b000) begin
            RegWe = 1;
            ALUSrc = 1;
        end

        //SLTI
        else if(OpCode == 7'b0010011 && Funct3 == 3'b010) begin
            RegWe = 1;
            ALUSelect = 4'b0110;
            ALUSrc = 1;
        end

        //SLTIU
        else if(OpCode == 7'b0010011 && Funct3 == 3'b011) begin
            RegWe = 1;
            ALUSelect = 4'b0111;
            ALUSrc = 1;
        end

        //XORI
        else if(OpCode == 7'b0010011 && Funct3 == 3'b100) begin
            RegWe = 1;
            ALUSelect = 4'b0100;
            ALUSrc = 1;
        end

        //ORI
        else if(OpCode == 7'b0010011 && Funct3 == 3'b110) begin
            RegWe = 1;
            ALUSelect = 4'b0011;
            ALUSrc = 1;
        end

        //ANDI
        else if(OpCode == 7'b0010011 && Funct3 == 3'b111) begin
            RegWe = 1;
            ALUSelect = 4'b0010;
            ALUSrc = 1;
        end

        //SLLI
        else if(OpCode == 7'b0010011 && Funct3 == 3'b001) begin
            RegWe = 1;
            ALUSelect = 4'b0101;
            ALUSrc = 1;
        end

        //SRLI
        else if(OpCode == 7'b0010011 && Funct3 == 3'b101 && Instruction[30] == 1) begin
            RegWe = 1;
            ALUSelect = 4'b1000;
            ALUSrc = 1;
        end

        //SRAI
        else if(OpCode == 7'b0010011 && Funct3 == 3'b101 && Instruction[30] == 0) begin
            RegWe = 1;
            ALUSelect = 4'b1001;
            ALUSrc = 1;
        end

        //R Instructions

        //ADD
        else if(OpCode == 7'b0110011 && Funct3 == 3'b000 && Instruction[30] == 0) begin
            RegWe = 1;
            Rs2 = Instruction[24:20];
        end

        //SUB
        else if(OpCode == 7'b0110011 && Funct3 == 3'b000 && Instruction[30] == 1) begin
            RegWe = 1;
            ALUSelect = 4'b0001;
            Rs2 = Instruction[24:20];
        end

        //SLL
        else if(OpCode == 7'b0110011 && Funct3 == 3'b001) begin
            RegWe = 1;
            ALUSelect = 4'b0101;
            Rs2 = Instruction[24:20];
        end

        //SLT
        else if(OpCode == 7'b0110011 && Funct3 == 3'b010) begin
            RegWe = 1;
            ALUSelect = 4'b0110;
            Rs2 = Instruction[24:20];
        end

        //SLTU
        else if(OpCode == 7'b0110011 && Funct3 == 3'b011) begin
            RegWe = 1;
            ALUSelect = 4'b0111;
            Rs2 = Instruction[24:20];
        end

        //XOR
        else if(OpCode == 7'b0110011 && Funct3 == 3'b100) begin
            RegWe = 1;
            ALUSelect = 4'b0100;
            Rs2 = Instruction[24:20];
        end

        //SRL
        else if(OpCode == 7'b0110011 && Funct3 == 3'b101 && Instruction[30] == 0) begin
            RegWe = 1;
            ALUSelect = 4'b1000;
            Rs2 = Instruction[24:20];
        end

        //SRLA
        else if(OpCode == 7'b0110011 && Funct3 == 3'b101 && Instruction[30] == 1) begin
            RegWe = 1;
            ALUSelect = 4'b1000;
            Rs2 = Instruction[24:20];
        end

        //OR
        else if(OpCode == 7'b0110011 && Funct3 == 3'b110) begin
            RegWe = 1;
            ALUSelect = 4'b0011;
            Rs2 = Instruction[24:20];
        end

        //SRLA
        else if(OpCode == 7'b0110011 && Funct3 == 3'b111) begin
            RegWe = 1;
            ALUSelect = 4'b0010;
            Rs2 = Instruction[24:20];
        end

        //FENCE
        else if(OpCode == 7'b0001111 && Funct3 == 3'b000) begin
            Flush = 1;
        end

        //FENCE.I
        else if(OpCode == 7'b0001111 && Funct3 == 3'b001) begin
            Flush = 1;
        end

        //ECALL
        else if(OpCode == 7'b1110011 && Funct3 == 3'b000 && Instruction[20] == 0) begin
            Stall = 1;
            SCallFlag = 1;
        end

        //EBREAK
        else if(OpCode == 7'b1110011 && Funct3 == 3'b000 && Instruction[20] == 1) begin
            Stall = 1;
            SBreakFlag = 1;
        end

        //RDCYCLE
        else if(OpCode == 7'b1110011 && Funct3 == 3'b010 && Instruction[29:20] == 0) begin
            RegWe = 1;
            WBSelect = 2'b11;
        end

        //RDCYCLEH
        else if(OpCode == 7'b1110011 && Funct3 == 3'b010 && Instruction[27] == 1 && Instruction[20] == 0) begin
            RegWe = 1;
            WBSelect = 2'b11;
        end

        //RDTIME
        else if(OpCode == 7'b1110011 && Funct3 == 3'b010 && Instruction[27] == 0 && Instruction[20] == 1) begin
            RegWe = 1;
            WBSelect = 2'b11;
        end 

        //RDTIMEH
        else if(OpCode == 7'b1110011 && Funct3 == 3'b010 && Instruction[27] == 1 && Instruction[20] == 1) begin
            RegWe = 1;
            WBSelect = 2'b11;
        end 
        
        //RDINSTRET
        else if(OpCode == 7'b1110011 && Funct3 == 3'b010 && Instruction[27] == 0 && Instruction[21] == 1) begin
            RegWe = 1;
            WBSelect = 2'b11;
        end 

        //RDINSTRETH
        else if(OpCode == 7'b1110011 && Funct3 == 3'b010 && Instruction[27] == 1 && Instruction[21] == 1) begin
            RegWe = 1;
            WBSelect = 2'b11;
        end 
     end
    
    
endmodule