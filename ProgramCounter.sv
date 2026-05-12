module programCounter(
    input logic Rst;
    input logic [31:0] address;
    output logic [31:0] out;
    );

    assign out = (Rst == 1) 32'b0:address;
    
endmodule