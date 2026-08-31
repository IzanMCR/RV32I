interface alu_if (input logic clk);
    logic [31:0] OperandA;
    logic [31:0] OperandB;
    logic [3:0]  ALUSelect;
    logic [4:0]  ROBTag;
    CDBData      Out;
endinterface

module top;
    logic clk;
    always #5 clk = ~clk;

    alu_if vif(clk);

    ALU ALUInst (
        .OperandA(vif.OperandA),
        .OperandB(vif.OperandB),
        .ALUSelect(vif.ALUSelect),
        .ROBTag(vif.ROBTag),
        .Out(vif.Out) 
    );

endmodule