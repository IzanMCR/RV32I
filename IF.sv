module IF(
    input logic Clk,
    input logic Rst,
    input logic Clear,
    input logic FlipFlopEn,
    input logic [31:0] Address,    
    output logic [31:0] Instruction
    );

    logic [31:0] AddressInstruction;
    logic [31:0] InstructionFromMemory;

    ProgramCounter ProgramCounterInst(
        .Clk(Clk),
        .Rst(Rst),
        .Address(Address),
        .Out(AddressInstruction)
    );

    InstructionMemory InstructionMemoryInst(
        .Clk(Clk),
        .Address(AddressInstruction),
        .Instruction(InstructionFromMemory)
    );
    
    FlipFlopSRC FlipFlopSRCInst(
        .Clk(Clk),
        .Clear(Clear),
        .Rst(Rst),
        .FlipFlopEn(FlipFlopEn),
        .DataIn(InstructionFromMemory),
        .DataOut(Instruction)

    );

endmodule