class CacheTestDriver extends uvm_driver #(CacheItem); 

    `uvm_component_utils(CacheTestDriver)
    virtual CacheInterface vif;

    function new(string name = "CacheTestDriver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
       
        if (!uvm_config_db#(virtual CacheInterface)::get(this, "", "vif", vif))
            `uvm_fatal("DRV", "Could not get vif")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            @(posedge vif.Clk);
            vif.Address     <= req.Address;
            vif.MemReady    <= req.MemReady;
            vif.MemReadData <= req.MemReadData;
            vif.WriteData   <= req.WriteData;
            vif.CacheWe     <= req.CacheWe;
            vif.ByteEnable  <= req.ByteEnable;
            seq_item_port.item_done();
        end
    endtask
    
endclass