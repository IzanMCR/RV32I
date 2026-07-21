typedef enum logic [3:0] {
    NO_EXCEPTION = 4'd0, 
    INSTRUCTION_MISALIGNED = 4'd1, 
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
    ExceptionsCode ExceptionCode;
    logic [31:0] PCAddress;
    } ROBEntry;

module ROB #(parameter ROBSize = 32, parameter TagSize = 5)(
    input logic Clk,
    input logic Rst,
    input logic Flush,
    input logic IssueEnable0,
    input logic [4:0] Rd0,
    input logic [1:0] Op0,
    input logic [31:0] PCAddress0,
    input logic IssueEnable1,
    input logic [4:0] Rd1,
    input logic [1:0] Op1,
    input logic [31:0] PCAddress1,
    output logic [TagSize - 1:0] Tag0,
    output logic [TagSize - 1:0] Tag1,
    output logic ROBFull,
    output logic ROBAlmostFull,
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
    output logic ExceptionTrig,
    output ExceptionsCode ExCodeOut,
    output logic [31:0] ExceptionPC,
    output logic        CommitEn0,
    output logic [4:0]  CommitReg0,
    output logic [31:0] CommitValue0,
    output logic        CommitEn1,
    output logic [4:0]  CommitReg1,
    output logic [31:0] CommitValue1
    );

    ROBEntry ROBEntries [ROBSize - 1:0];

    logic [TagSize - 1:0] Head;
    logic [TagSize - 1:0] Tail;
    logic [TagSize - 1:0] NextHead;
    logic [TagSize - 1:0] NextTail;

    assign Tag0 = Tail;
    assign Tag1 = Tail + 1'b1;  
    assign NextHead = Head + 1'b1;
    assign NextTail = IssueEnable0 ? (Tail + 1'b1) : Tail;  
    assign ExceptionTrig = ROBEntries[Head].Ready && ROBEntries[Head].Busy && ROBEntries[Head].Exception;
    assign ExCodeOut     = ROBEntries[Head].ExceptionCode;
    assign ExceptionPC   = ROBEntries[Head].PCAddress;

    assign ROBFull = ((Tail + 1'b1) & (ROBSize - 1)) == Head;
    assign ROBAlmostFull = ((Tail + 2'd2) & (ROBSize - 1)) == Head;

    always_comb begin
        CommitEn0 = ROBEntries[Head].Ready && ROBEntries[Head].Busy && !ROBEntries[Head].Exception;
        CommitReg0 = ROBEntries[Head].Destination;
        CommitValue0 = ROBEntries[Head].Value;
        CommitEn1 = CommitEn0 && ROBEntries[NextHead].Ready == 1 && ROBEntries[NextHead].Busy && !ROBEntries[NextHead].Exception;
        CommitReg1 = ROBEntries[NextHead].Destination;
        CommitValue1 = ROBEntries[NextHead].Value;
    end

    always_ff @(posedge Clk) begin
        if(Flush || Rst) begin
                Head <= '0;
                Tail <= '0;
                ROBEntries <= '0;
        end
        else begin 

            if(!ROBFull) begin
                if(IssueEnable0) begin
                    ROBEntries[Tail].Busy <= 1'b1;
                    ROBEntries[Tail].Ready <= 1'b0;
                    ROBEntries[Tail].Destination <= Rd0;
                    ROBEntries[Tail].Operation <= Op0;
                    ROBEntries[Tail].PCAddress <= PCAddress0;
                end
                if(IssueEnable1) begin
                    ROBEntries[NextTail].Busy <= 1'b1;
                    ROBEntries[NextTail].Ready <= 1'b0;
                    ROBEntries[NextTail].Destination <= Rd1;
                    ROBEntries[NextTail].Operation <= Op1;
                    ROBEntries[NextTail].PCAddress <= PCAddress1;
                end 
                Tail <= Tail + {4'b0, IssueEnable0} + {4'b0, IssueEnable1};
            end

            if(CDBValid0) begin
                ROBEntries[CDBTag0].Value <= CDBValue0;
                ROBEntries[CDBTag0].Ready <= 1'b1;
            end
            if(CDBValid1) begin
                ROBEntries[CDBTag1].Value <= CDBValue1;
                ROBEntries[CDBTag1].Ready <= 1'b1;
            end

            if (CommitEn0) ROBEntries[Head].Busy <= 1'b0;
            if (CommitEn1) ROBEntries[NextHead].Busy <= 1'b0;

            Head <= Head + {4'b0, CommitEn0} + {4'b0, CommitEn1};
        end
    end    


endmodule