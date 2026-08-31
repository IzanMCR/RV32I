//As we are going to use a RS for each logic unit and all ops occurs in the same cycles we just need a pointer that +1 when we create a 
//enter and -1 when quit it. 

typedef struct packed {
        logic                Busy;
        logic [6:0]          Op;
        logic [31:0]         Vj;
        logic [31:0]         Vk;
        logic [4:0]          Qj;     
        logic [4:0]          Qk;     
        logic [31:0]         Addr;
        logic [4:0]          RobTag;   
    } ResSta;

module ReservationStation#(parameter ResStaSize = 4, parameter TagSize = 5, parameter RSTag = 2'b00)(
    input logic Clk,
    input logic Rst,
    input logic Flush,
    input logic Ready,
    input logic Input,
    input logic Head,
    input logic [6:0] OpCode,
    input logic [TagSize - 1:0] ROBTag,
    input logic [1:0] Tag;
    input logic CDBValid0,
    input logic [TagSize - 1:0]CDBTag0,
    input logic [31:0]CDBValue0,
    input logic CDBException0,             
    input ExceptionsCode CDBExCode0,
    input logic CDBValid1,
    input logic [TagSize - 1:0] CDBTag1,
    input logic [31:0] CDBValue1,
    input logic CDBException1,           
    input ExceptionsCode CDBExCode1,
    );

    logic [4:0] Pointer;

    logic [31:0] Registers; //It is gonna save 0 if it no uses in any ResStaIns and the ROBTag tag if register is used is one of them
    ResSta [ResStaSize - 1:0] ResStaIns;

    always_ff @(posedge Clk) begin
        if(!Rst || Flush) begin
            ResStaIns <= '0;
        end
        else begin
            if(Input) begin
                ResStaIns[Pointer].Busy <= 1'b1;
                ResStaIns[Pointer].Op <= OpCode;
                Pointer <= Pointer + 1;
            end
        end
    end

endmodule