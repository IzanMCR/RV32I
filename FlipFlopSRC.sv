module FlipFlopSRC(
    input logic Clk,
    input logic Clear,
    input logic Rst,
    input logic FlipFlopEn,
    input logic [31:0] DataIn,
    output logic [31:0] DataOut
    );

    always_ff @(posedge Clk) begin
        if(Rst) DataOut <= 32'b0;
        if (FlipFlopEn) begin
            if(Clear) DataOut <= 32'b0;
            else DataOut <= DataIn;
        end
    end
endmodule