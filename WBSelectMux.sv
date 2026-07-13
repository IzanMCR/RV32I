module WBSelectMux(
    input logic [31:0] ALUResult,
    input logic [31:0] MemoryResult,
    input logic [31:0] PCAddress,
    input logic [31:0] Counter,
    input logic [31:0] WBSelect,
    output logic [31:0] Result
    );

    always_comb begin 
        case(WBSelect)
            2'b00: Result = ALUResult;
            2'b01: Result = MemoryResult;
            2'b10: Result = PCAddress;
            2'b11: Result = Counter;
        endcase
    end

endmodule