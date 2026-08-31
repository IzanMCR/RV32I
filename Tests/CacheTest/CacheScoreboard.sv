class CacheScoreboard extends uvm_scoreboard;

    `uvm_component_utils(CacheScoreboard)
    uvm_analysis_imp #(CacheItem, CacheScoreboard) item_collected_export;

    function new(string name, uvm_component parent);
      super.new(name, parent);
      item_collected_export = new("item_collected_export", this);
    endfunction

    logic [31:0] mem [int];

    virtual function void write(CacheItem Item);
      if (Item.We == 1) begin
        
      end
      `uvm_info("SCB", $sformatf("Transacción recibida para Address: %0h", Item.Address), UVM_HIGH)
    endfunction

endclass