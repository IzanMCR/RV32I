typedef enum logic [1:0] {
        STRONGLYTAKEN  = 2'b11,
        WEAKLYTAKEN = 2'b10,
        WEAKLYNOTTAKEN = 2'b01,
        STRONGLYNOTTAKEN  = 2'b00
    } States;

module BranchPredictor (
    input logic Clk,
    input logic Rst,
    input  logic [31:0] FetchPC,
    output logic BranchPrediction //1: Yes 0: No
    input logic UpdateEn,         
    input logic [31:0] UpdatePC,   
    input logic BranchTaken   
    );

    logic [1:0] BHT [0:1023];

    logic [9:0] FetchIndex;
    logic [9:0] UpdateIndex;

    assign FetchIndex  = FetchPC[11:2];
    assign UpdateIndex = UpdatePC[11:2];
    
    assign BranchPrediction = (BHT[FetchIndex][1]);

    always_ff @(posedge Clk) begin
        if(!Rst) begin
            for (int i = 0; i < 1024; i++) begin
                BHT[i] <= WEAKLYNOTTAKEN;
            end
        end
        else if (UpdateEn) begin
            case (BHT[UpdateIndex])
                STRONGLYNOTTAKEN: BHT[UpdateIndex] <= BranchTaken ? WEAKLYNOTTAKEN : STRONGLYNOTTAKEN;
                WEAKLYNOTTAKEN:   BHT[UpdateIndex] <= BranchTaken ? WEAKLYTAKEN    : STRONGLYNOTTAKEN;
                WEAKLYTAKEN:      BHT[UpdateIndex] <= BranchTaken ? STRONGLYTAKEN  : WEAKLYNOTTAKEN;
                STRONGLYTAKEN:    BHT[UpdateIndex] <= BranchTaken ? STRONGLYTAKEN  : WEAKLYTAKEN;
            endcase
        end
    end

endmodule