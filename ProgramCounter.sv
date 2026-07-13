module ProgramCounter(
    input logic Rst,
    input logic Clk,
    input logic [31:0] Address,
    output logic [31:0] Out
    );

    always_ff @(posedge Clk)begin
        Out <= (!Rst) ? 32'b0 : Address;
    end

endmodule