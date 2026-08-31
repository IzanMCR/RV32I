class ALUTestDriver extends uvm_driver #(ALUItem);

    `uvm_component_utils(ALUTestDriver)

    virtual alu_if vif;

    function new(string name, uvm_component parent)
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            vif.OperandA <= req.OperandA;
            vif.OperandB <= req.OperandB;
            vif.ALUSelect <= req.ALUSelect;
            vif.ROBTag <= req.ROBTag;
            seq_item_port.item_done();
        end
    endtask

endclass