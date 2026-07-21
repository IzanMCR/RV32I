module RAM(
    input logic Clk,
    input logic [5:0] Address,
    input logic [31:0] Data,
    input logic WriteMask,
    input logic [3:0] ByteEnable,
    input logic MemWe,
    input logic MemRead,
    output logic [31:0] DataOut,
    output logic MemReady
    );
    assign [31:0] Memory [0:511];
    logic [1:0] DataToWrite;

    always_ff @(posedge clk) begin
        if(MemRead) begin
            if()
            if(ByteEnable[3]) Memory[Address][31:24] <= WriteData[31:24];
            if(ByteEnable[2]) Memory[Address][23:16] <= WriteData[23:16];
            if(ByteEnable[1]) Memory[Address][15:8] <= WriteData[15:8];
            if(ByteEnable[0]) Memory[Address][7:0] <= WriteData[7:0];
        end
    end

    assign DataOut <= Memory[Address];
endmodule