//Este módulo será una caché L1 de 32 conjuntos y 2 vías usando 4KB de la BRAM
//Offset = 6b; Índice = 5b; Tag = 21b
//As we are gonna use a small cache the replace algorithm that we are gonna use is LRU.
//If you want to implement big caches please use Pseudo-LRU, it works better in those case ;)

module Cache(
    input logic Clk,
    input logic Rst,
    input logic [31:0] Address,
    input logic MemReady,
    input logic [63:0] MemReadData,
    input logic [31:0] WriteData,
    input logic CacheWe,
    input logic [3:0] ByteEnable,
    output logic Stall,
    output logic [63:0] MemWriteData,
    output logic MemWe,
    output logic MisalignedException,
    output logic [31:0] DataOut
    );

    
    logic ValidWay0 [31:0];
    logic DirtyWay0 [31:0];
    logic [20:0] TagWay0 [31:0];
    logic [511:0] DataWay0 [31:0];

    logic ValidWay1 [31:0];
    logic DirtyWay1 [31:0];
    logic [20:0] TagWay1 [31:0];
    logic [511:0] DataWay1 [31:0];

    logic LRU [31:0];

    logic [5:0] Offset;
    logic [4:0] Index;
    logic [20:0] Tag;
    logic [31:0] DataToOutput0;
    logic [31:0] DataToOutput1;
    logic Dirty;
    
    assign Offset = Address[5:0];
    assign Index = Address[10:6];
    assign Tag = Address[31:11];
    assign Dirty = (LRU[Index]) ? DirtyWay0[Index] : DirtyWay1[Index];

    logic Hit0;
    logic Hit1;
    logic Hit;

    logic Miss = ~Hit;

    assign Hit0 = (TagWay0[Index] == Tag && ValidWay0[Index] == 1) ? 1 : 0; 
    assign Hit1 = (TagWay1[Index] == Tag && ValidWay1[Index] == 1) ? 1 : 0;

    assign Hit = Hit0 | Hit1;
    
    assign DataToOutput0 = DataWay0[Index][{Offset, 3'b000} +: 32];
    assign DataToOutput1 = DataWay1[Index][{Offset, 3'b000} +: 32];

    logic [2:0] Counter;
    
    CacheFSM CacheFSMInst(
        .Clk(Clk),
        .Rst(Rst),
        .MemReady(MemReady),
        .Miss(Miss),
        .Dirty(Dirty),
        .Data(Data),
        .MemRead(MemRead),
        .MemWe(MemWe),
        .Counter(Counter)
    );

    always_comb begin

        DataOut = 32'b0;
        MisalignedException = (ByteEnable == 4'b1111) ? (((n >> 2) << 2) != Address) : (ByteEnable == 4'b0011) ? (((n >> 1) << 1) != Address) : 0;

        if(MemWe && LRU[Index] == 0) MemWriteData = DataWay0[Index][Counter * 64 +: 64];
        else if(MemWe && LRU[Index] == 1) MemWriteData = DataWay1[Index][Counter * 64 +: 64];

        if(Hit0) begin
            DataOut[31:24] = (ByteEnable[3]) ? DataToOutput0[31:24] : 8'b0;
            DataOut[23:16] = (ByteEnable[2]) ? DataToOutput0[23:16] : 8'b0; 
            DataOut[15:8] = (ByteEnable[1]) ? DataToOutput0[15:8] : 8'b0;
            DataOut[7:0] = (ByteEnable[0]) ? DataToOutput0[7:0] : 8'b0;
        end
        else if(Hit1) begin
            DataOut[31:24] = (ByteEnable[3]) ? DataToOutput1[31:24] : 8'b0;
            DataOut[23:16] = (ByteEnable[2]) ? DataToOutput1[23:16] : 8'b0; 
            DataOut[15:8] = (ByteEnable[1]) ? DataToOutput1[15:8] : 8'b0;
            DataOut[7:0] = (ByteEnable[0]) ? DataToOutput1[7:0] : 8'b0;
        end
    end

    always_ff @(posedge Clk) begin
        if(Rst) begin 
            for(int i = 0; i < 32; i++) begin
                ValidWay0[i] <= 'b0;
                DataWay0[i] <= 'b0;
                DirtyWay0[i] <= 'b0;
                ValidWay1[i] <= 'b0;
                DataWay1[i] <= 'b0;
                DirtyWay1[i] <= 'b0;
            end
        end
        if(Miss) begin

            if(LRU[Index] == 0 && MemReady) DataWay0[Index][Counter * 64 +: 64] <= MemReadData;
            else if(MemReady && LRU[Index] == 1) DataWay1[Index][Counter * 64 +: 64] <= MemReadData;

            if (Counter == 3'd7) begin
                if (LRU[Index] == 0) begin
                    TagWay0[Index]   <= Tag;
                    ValidWay0[Index] <= 1'b1;
                    DirtyWay0[Index] <= 1'b0; 
                end else begin
                    TagWay1[Index]   <= Tag;
                    ValidWay1[Index] <= 1'b1;
                    DirtyWay1[Index] <= 1'b0; 
                end
            end
        end

        if(Hit && CacheWe) begin
            if(Hit0) begin 
                if(ByteEnable[3]) DataWay0[Index][{Offset, 3'b000} + 24 +: 8] <= WriteData[31:24];
                if(ByteEnable[2]) DataWay0[Index][{Offset, 3'b000} + 16 +: 8] <= WriteData[23:16];
                if(ByteEnable[1]) DataWay0[Index][{Offset, 3'b000} +  8 +: 8] <= WriteData[15:8];
                if(ByteEnable[0]) DataWay0[Index][{Offset, 3'b000} +: 8] <= WriteData[7:0];
                    
                DirtyWay0[Index] <= 1'b1;
                end 
            else if(Hit1) begin 
                if(ByteEnable[3]) DataWay1[Index][{Offset, 3'b000} + 24 +: 8] <= WriteData[31:24];
                if(ByteEnable[2]) DataWay1[Index][{Offset, 3'b000} + 16 +: 8] <= WriteData[23:16];
                if(ByteEnable[1]) DataWay1[Index][{Offset, 3'b000} +  8 +: 8] <= WriteData[15:8];
                if(ByteEnable[0]) DataWay1[Index][{Offset, 3'b000} +: 8] <= WriteData[7:0];
                    
                DirtyWay1[Index] <= 1'b1; 
            end
        end
    end
endmodule