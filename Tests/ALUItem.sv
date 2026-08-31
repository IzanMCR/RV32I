typedef struct packed {
    logic [31:0] data_out;
    logic [4:0]  rob_tag;
    logic        valid;
} CDBData;

class ALUItem extends uvm_sequence_item;

    rand logic [31:0] OperandA;
    rand logic [31:0] OperandB;
    rand logic [3:0] ALUSelect;
    rand logic [4:0] ROBTag;
    CDBData Out;

    `uvm_object_utils_begin(ALUItem)
        `uvm_field_int(OperandA, UVM_ALL_ON)
        `uvm_field_int(OperandB, UVM_ALL_ON)
        `uvm_field_int(ALUSelect, UVM_ALL_ON)
        `uvm_field_int(ROBTag, UVM_ALL_ON)
        `uvm_field_int(Out, UVM_ALL_ON)
    `uvm_object_utils_end
    
    function new(string name = "ALUItem");
        super.new(name);
    endfunction

endclass