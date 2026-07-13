module ReservationStation(
    input logic clk,
    input logic rst,
    input logic flush,
    input logic [4:0] ALUSelect,
    input logic [1:0] IssueEnable 
    );

    typedef struct packed {
        logic                Busy;
        logic [4:0]          Op;
        logic [31:0]         Vj;
        logic [31:0]         Vk;
        logic [4:0]          Qj;     
        logic [4:0]          Qk;     
        logic [31:0]         Addr;
        logic [4:0]          Dest;   
    } ResSta;

    ResSta ResStaIns [31:0];

    
endmodule