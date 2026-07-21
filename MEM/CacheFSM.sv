module CacheFSM(
    input logic [31:0] Address,
    input logic Rst,
    input logic Clk,
    input logic MemReady,
    input logic Miss,
    input logic Dirty,
    output logic Data,
    output logic MemRead,
    output logic MemWe,
    output logic [2:0] Counter, 
    output logic Stall
    );

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        WRITEBACK = 2'b01,
        ALLOC  = 2'b10
    } States;

    States CurrentState;
    States NextState;

    always_ff @(posedge Clk) begin
        if(!Rst) begin
            CurrentState <= IDLE;
            Counter <= 3'b000;
        end
        else begin
            CurrentState <= NextState;
            if(CurrentState == IDLE) Counter <= 3'b000;
            else if(MemReady) Counter = Counter + 1'b1;
        end
    end

    always_comb begin
        NextState = CurrentState;
        Stall = 0;
        MemRead = 0;
        MemWe = 0;
        case(CurrentState)
            IDLE: begin
                if (!Miss) NextState = IDLE;
                else if (Dirty) NextState = WRITEBACK;
                else NextState = ALLOC;
                end
            WRITEBACK: begin
                Stall = 1;
                MemWe = 1;
                if(Counter == 3'd7 && MemReady) NextState = ALLOC;
            end
            ALLOC: begin
                Stall = 1;
                MemRead = 1;
                if(Counter == 3'd7 && MemReady) NextState = IDLE;
            end
            default: NextState = IDLE;
        endcase
    end
endmodule

    