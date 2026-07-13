module ROB(
    input logic Clk,
    input logic Rst,
    input logic Flush,
    input logic DestinationInvalid,
    input logic [1:0] IssueEnable,
    input logic [5:0] Rd,
    input logic [1:0] Op,
    input logic [36:0] CDBusALU,
    input logic Exception,
    input logic [31:0] PCAddress,
    input logic ExceptionsCode,
    output logic Value,
    output logic Destination
    );

    typedef enum logic [3:0] {
        NO_EXCEPTION = 4'd0, 
        INSTRUCTION_MISALIGNED = 4'd0, 
        ILLEGAL_INSTRUCTION = 4'd2,
        BREAKPOINT = 4'd3,
        LOAD_MISALIGNED = 4'd4,
        LOAD_FAULT = 4'd5,
        STORE_MISALIGNED = 4'd6,
        STORE_FAULT = 4'd7,
        ENV_CALL = 4'd11
    } ExceptionsCode;

    typedef struct packed {
        logic Ready;
        logic Busy;
        logic [4:0] Destination;
        logic [31:0] Value;
        logic [1:0] Operation; //00 ALU OP 01 Brach 10 Memory
        logic Exception;
        logic ExceptionsCode ExceptionsCode;
        logic PCAddress;
    } ROBEntry;

    ROBEntry ROBEntries0 [63:0];

    logic [4:0] Head;
    logic [4:0] Tail;

    always_comb begin
        Head = 5'b0;
        Tail = 5'b0;
        if(ROBEntries[Tail].Busy == 0) begin
            ROBEntries[Tail].Ready = 0;
            ROBEntries[Tail].Destination = Rd;

        end 
        if(Exception || Tail + 1 == Head) Stall = 1;
        else if ((Tail + 1) % Capacidad != Head) ROBEntries[Tail] = ROBEntry;
        if(ROBEntries[Head].Ready == 1) begin
            ROBEntries[Head].Busy = 0;
            Head = Head + 1;
            Value = ROBEntries[Head].Value;
            Destination = ROBEntries[Head].Destination  ;
        end
    end    


endmodule