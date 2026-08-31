class CacheSequencer extends uvm_sequencer #(CacheItem);
    `uvm_component_utils(CacheSequencer) 

    function new(string name = "CacheSequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass