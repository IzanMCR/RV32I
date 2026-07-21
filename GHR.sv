module GHR(
    input Clk,
    input Branch,
    output [127:0] Branchs
    );

    logic [127:0] LastBranchs;

    always_ff @(posedge Clk) begin
        LastBranchs <= {LastBranchs[126:0], Branch};
    end
    
    assign Branchs = LastBranchs;

endmodule