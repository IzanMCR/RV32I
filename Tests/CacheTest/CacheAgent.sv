class CacheAgent extends uvm_agent;

    `uvm_component_utils(CacheAgent)
    CacheTestDriver Driver;   
    CacheSequencer  Sequencer; 
    CacheMonitor    Monitor;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        Monitor = CacheMonitor::type_id::create("Monitor", this);
        if(get_is_active() == UVM_ACTIVE) begin
            Driver    = CacheTestDriver::type_id::create("Driver", this);
            Sequencer = CacheSequencer::type_id::create("Sequencer", this);
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        if(get_is_active() == UVM_ACTIVE) begin
            Driver.seq_item_port.connect(Sequencer.seq_item_export);
        end
    endfunction
    
endclass