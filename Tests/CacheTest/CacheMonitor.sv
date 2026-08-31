class CacheMonitor extends uvm_monitor;
  `uvm_component_utils(CacheMonitor)
  virtual adder_if vif;
  uvm_analysis_port #(CacheItem) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual CacheInterface)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", "Interface not found");
  endfunction

  task run_phase(uvm_phase phase);
    CacheItem Item;
    forever begin
        @(posedge vif.clk);
        Item = adder_item::type_id::create("Item");
        Item.Rst = vif.Rst;
        Item.Address = vif.Address;
        Item.MemReady = vif.MemReady;
        Item.MemReadData = vif.MemReadData;
        Item.WriteData = vif.WriteData;
        Item.CacheWe = vif.CacheWe;
        Item.ByteEnable = vif.ByteEnable;
        Item.Stall = vif.Stall;
        Item.MemWriteData = vif.MemWriteData;
        Item.MemWe = vif.MemWe;
        Item.DataOuT = vif.DataOuT;
        ap.write(Item);
    end
  endtask
endclass