interface CacheInterface(input logic Clk, input logic Rst);

    logic [31:0] Address;
    logic        MemReady;
    logic [63:0] MemReadData;
    logic [31:0] WriteData;
    logic        CacheWe;
    logic [3:0]  ByteEnable;
    logic        Stall;
    logic [63:0] MemWriteData;
    logic        MemWe;
    logic [31:0] DataOut;
    
endinterface