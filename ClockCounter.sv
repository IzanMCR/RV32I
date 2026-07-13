module ClockCounter(
    input logic Clk,
    input logic Rst,
    output logic [31:0] Cycles
    );


    always_ff @(posedge Clk) begin
        if(Rst) Cycles <= '0;
        else Cycles <= Cycles + 1;
    end
endmodule