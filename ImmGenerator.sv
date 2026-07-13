module ImmGenerator(
    input logic [31:0] Instruction,
    output logic [31:0] Imm
    );

    logic [6:0] OpCode;

    assign OpCode = Instruction[6:0];

    always_comb begin
 

        case(OpCode)
            
            //S-Instructions
            7'b0100011: Imm = {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]};

            //SB-Instructions
            7'b1100011: Imm = {{20{Instruction[31]}}, Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0};

            //U-Instructions
            7'b0110111: Imm = {Instruction[31:12], 12'b0};
            7'b0010111: Imm = {Instruction[31:12], 12'b0};

            //UJ-Instructions
            7'b1101111: Imm = {{12{Instruction[31]}}, Instruction[19:12], Instruction[20], Instruction[30:21], 1'b0};

            //I-Instructions -> We use default case to I-Instructions to save some LUTs
            default: Imm = {{20{Instruction[31]}}, Instruction[31:20]};;
            
        endcase
    end

endmodule