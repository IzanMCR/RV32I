module Decoder(
    input logic [31:0] Instruction,
    output logic [4:0] Rs1,
    output logic [4:0] Rs2,
    output logic [4:0] Rd,
    output logic [6:0] Funct7,
    output logic RegWe,
    output logic [2:0] Funct3,
    output logic [31:0] Imm,
    output logic [6:0] OpCode,
    output logic [3:0] ALUSelect,
    output logic ALUSrc //1 = imm, 0 = reg
    );
     always_comb begin

        assign OpCode = Instruction[6:0];
        assign Funct3 = Instruction[14:12];
        
        //U-instructions

        //AUIPC
        if(OpCode == 7'b0010111) begin
           Rd = Instruction[11:7];
           RegWe = 1;
           Imm = {Instruction[31:12], 12'b0}; 
           ALUSrc = 1;
        end

        //LUI
        else if(OpCode == 7'b0110111) begin
            Rd = Instruction[11:7];
            RegWe = 1;
            Imm = {Instruction[31:12], 12'b0}; 
            ALUSrc = 1;
        end
        
        //J-instructions

        //Jal
        else if (OpCode == 7'b1101111) begin
            Rd = Instruction[11:7];
            ALUSelect = 4'b0000;
            RegWe = 1;
            Imm = {12{Instruction[31]}, Instruction[19:12], Instruction[20], Instruction[30:21], 1'b0};
            ALUSrc = 1;
        end

        //Jalr
        else if(OpCode == 7'b1100111 && Funct3 == 3'b000) begin
            Rd = Instruction[11:7];
            ALUSelect = 4'b0000;
            RegWe = 1;
            Rs1 = Instruction[19:15];
            Imm = Instruction[31:20];
            ALUSrc = 1;
        end

        else if(OpCode == 7'b1100011 && Funct3 == 3'b000) begin
            ALUSelect = 4'b0000;
            RegWe = 1;
            Rs1 = Instruction[19:15];
            Imm = Instruction[31:20];
            ALUSrc = 1;
        end
     end
    
    
endmodule