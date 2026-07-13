module RegFile(
    input logic Clk,
    input logic [31:0] Data,
    input logic Rst,
    input logic [4:0] Rd,
    input logic [4:0] Rs1,
    input logic [4:0] Rs2,
    input logic We,
    output logic [31:0] Rs1Out,
    output logic [31:0] Rs2Out
    );

    logic [31:0] Rf [31:1];

    always_ff @(posedge Clk) begin 
        if(Rst) for(int i = 0; i < 32; i++) Rf[i] <= 32'b0;
        if(We && Rd != 5'b0) Rf[Rd] <= Data;
    end

    assign Rs1Out = (Rs1 == 0) ?  32'b0 : ((We && (Rd == Rs1)) ? Data : Rf[Rs1]);
    assign Rs2Out = (Rs2 == 0) ? 32'b0 : ((We && (Rd == Rs2)) ? Data : Rf[Rs2]);
endmodule