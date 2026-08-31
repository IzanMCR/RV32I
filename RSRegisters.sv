typedef struct packed {
        logic Busy;
        logic Select; //0: Value, 1: ROBTag
        logic [31:0] Value;
        logic [31:0] ROBTag;
    } ResSta;
    
module RSRegisters(
        input logic Clk,
        input logic Ready,
        input logic [31:0] Value,
        output logic [31:0],
        output logic [31:0]
    );

    logic [31:0] Registers;

    always_ff @(Clk) begin 
        if(Ready) begin
            
        end
    end

endmodule