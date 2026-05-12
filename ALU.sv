module ALU(
    input logic [31:0] OperandA,
    input logic [31:0] OperandB,
    input logic [3:0] ALUSelect,
    output logic [31:0] Result
    );

    logic [31:0] Add, Sub, And, Or, Xor, Sll, Slt, Sltu, Srl, Sra; 

    assign Add = OperandA + OperandB;
    assign Sub = OperandA - OperandB;
    assign And = OperandA & OperandB;
    assign Or = OperandA | OperandB;
    assign Xor = OperandA ^ OperandB;
    assign Sll = OperandA << OperandB[4:0];
    assign Slt = ($signed(OperandA) < $signed(OperandB));
    assign Sltu = (OperandA < OperandB);
    assign Srl = OperandA >> OperandB[4:0];
    assign Sra = ($signed(OperandA) >>> OperandB[4:0]);

    always_comb begin
        case(ALUSelect) 
            4'b0000: Result = Add;
            4'b0001: Result = Sub;
            4'b0010: Result = And;
            4'b0011: Result = Or;
            4'b0100: Result = Xor;
            4'b0101: Result = Sll;
            4'b0110: Result = Slt;
            4'b0111: Result = Sltu;
            4'b1000: Result = Srl;
            4'b1001: Result = Sra;
            default: Result = 32'b0;
        endcase
    end
endmodule