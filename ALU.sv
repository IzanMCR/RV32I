typedef struct packed {
    logic          Valid;      
    logic [4:0]    ROBTag;    
    logic [31:0]   Result;
    } CDBData;

module ALU(
    input logic [31:0] OperandA,
    input logic [31:0] OperandB,
    input logic [3:0] ALUSelect,
    input logic [4:0] ROBTag,
    input logic Enable,
    output CDBData Out
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
        Out.Valid = (Enable == 1) ? 1:0;
        Out.ROBTag = ROBTag;
        case(ALUSelect) 
            4'b0000: Out.Result = Add;
            4'b0001: Out.Result = Sub;
            4'b0010: Out.Result = And;
            4'b0011: Out.Result = Or;
            4'b0100: Out.Result = Xor;
            4'b0101: Out.Result = Sll;
            4'b0110: Out.Result = Slt;
            4'b0111: Out.Result = Sltu;
            4'b1000: Out.Result = Srl;
            4'b1001: Out.Result = Sra;
            default: Out.Result = 32'b0;
        endcase
    end
endmodule