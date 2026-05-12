module ALU(
    input logic [31:0] OperandA;
    input logic [31:0] OperandB;
    input logic [3:0] AluSelect;
    output logic [31:0] Result;
    );

    logic [31:0] Add, Sub, And, Or, Xor, Sll, Slt, Sltu, Srl, Sra,  

    assign Add = OperandA + OperandB;
    assign Sub = OperandA - OperandB;
    assign And = OperandA & OperandB;
    assign Or = OperandA | OperandB;
    assign Xor = OperandA ^ OperandB;
    assign Sll = OperandA << OperandB;
    assign Slt = (OperandA < OperandB)  ? 1:0
    assign Sltu = ($unsigned(OperandA) < $unsigned(OperandB))  ? 1:0
    assign Srl = OperandA >> OperandB;
    assign Sra = 

    always_comb begin
        case(AluSelect) 
            4'b0000: result = Add;
            4'b0001: result = Sub;
            4'b0010: result = And;
            4'b0011: result = Or;
            4'b0100: result = Xor;
            4'b0101: result = Sll;
            4'b0110: result = Slt;
            4'b0111: result = Sltu;
            4'b1000: result = Srl;
            4'b1001: result = Sra;
            default: result = 32'b0;
        endcase
    end
endmodule