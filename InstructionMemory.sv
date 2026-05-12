module InstructionMemory(
    input logic [31:0] address;
    output logic [31:0] instruction;
    );

    logic [31:0] memory [4095:0];

    assign instruction = memory[address];
    
endmodule