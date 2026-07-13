module BranchUnit(
    input logic [31:0] Rs1Out,
    input logic [31:0] Rs2Out,
    input logic [2:0] Funct3,
    output logic Jump
    );

    always_comb begin
        case(Funct3) 
            3'b000: Jump = (Rs1Out == Rs2Out);
            3'b001: Jump = (Rs1Out != Rs2Out);
            3'b100: Jump = ($signed(Rs1Out) < $signed(Rs2Out));
            3'b101: Jump = ($signed(Rs1Out) >= $signed(Rs2Out));
            3'b110: Jump = (Rs1Out < Rs2Out);
            3'b111: Jump = (Rs1Out >= Rs2Out);
            default: Jump = 1'b0;
        endcase
    end

endmodule