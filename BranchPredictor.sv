module BranchPredictor (
    input logic Clk,
    input logic Rst,
    input logic Update_En,         
    input logic [31:0] Update_PC,   
    input logic BranchTaken,
    output logic BranchPrediction //1: Yes 0: No
    );

    typedef enum logic [1:0] {
        STRONGLYTAKEN  = 2'b11,
        WEAKLYTAKEN = 2'b10,
        WEAKLYNOTTAKEN = 2'b01,
        STRONGLYNOTTAKEN  = 2'b00
    } States;

    States CurrentState;
    States NextState;

    always_ff @(posedge Clk) begin
        if(!Rst) begin
            CurrentState <= WEAKLYNOTTAKEN;
        end
        else begin
            CurrentState <= NextState;
        end
    end

    always_comb begin
        NextState = CurrentState;
        case(CurrentState)
            STRONGLYNOTTAKEN: begin
                if (BranchTaken) NextState = WEAKLYNOTTAKEN;
                else NextState = STRONGLYNOTTAKEN;
                BranchPrediction = 0;
                end
            WEAKLYNOTTAKEN: begin
                if (BranchTaken) NextState = WEAKLYTAKEN;
                else NextState = STRONGLYNOTTAKEN;
                BranchPrediction = 0;
            end
            WEAKLYTAKEN: begin
                if (BranchTaken) NextState = STRONGLYTAKEN;
                else NextState = WEAKLYNOTTAKEN;
                BranchPrediction = 1;
            end
            STRONGLYTAKEN: begin
                if (BranchTaken) NextState = STRONGLYTAKEN;
                else NextState = WEAKLYTAKEN;
                BranchPrediction = 1;
            end
            default: NextState = WEAKLYNOTTAKEN;
        endcase
    end

endmodule