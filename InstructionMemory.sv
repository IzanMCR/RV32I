module InstructionMemory(
    input logic Clk,
    input logic [31:0] Address;
    output logic [31:0] Instruction;
    );

    logic [31:0] Memory [4095:0];

    initial begin
        $readmemh("rom.hex", Memory);
    end

    always_ff @(posedge Clk) begin
        else Instruction <= Memory[Address[13:2]];
    end
    
endmodule