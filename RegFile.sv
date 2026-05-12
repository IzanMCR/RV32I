module RegFile(
    input logic clk;
    input logic [31:0] Data;
    input logic Rst;
    input logic [4:0] Rd;
    input logic [4:0] Rs1;
    input logic [4:0] Rs2;
    input logic We;
    output logic [31:0] Rs1Out;
    output logic [31:0] Rs2Out;
    );

    assign [31:0] Rf [31:1];

    always_ff @(posedge clk) begin : 
        if(Rst) for(i = 0; i < 32; i++) Rf <= 32'b0;
        if(We) Rf[Rd] <= Data;
    end

    assign Rs1Out = (Rs1 == 0) 0:Rf[Rs1];
    assign Rs2Out = (Rs2 == 0) 0:Rf[Rs2];
endmodule