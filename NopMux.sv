module NopMux(
    input logic [31:0] Instruction,
    input logic Stall,
    output logic InstructionToExecute
    );

    localparam NOP = 32'h00000013;

    always_comb begin
        InstructionToExecute = (Stall) ? NOP : Instruction;
    end
    
endmodule