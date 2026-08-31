class CacheItem extends uvm_sequence_item;

    rand logic [31:0] Address;
    logic        MemReady;
    logic [63:0] MemReadData;
    rand logic [31:0] WriteData;
    rand logic        CacheWe;
    rand logic [3:0]  ByteEnable;
    logic        Stall;
    logic [63:0] MemWriteData;
    logic        MemWe;
    logic [31:0] DataOut;

    `uvm_object_utils_begin(CacheItem) 
        `uvm_field_int(Address, UVM_ALL_ON)
        `uvm_field_int(MemReady, UVM_ALL_ON)
        `uvm_field_int(MemReadData, UVM_ALL_ON)
        `uvm_field_int(WriteData, UVM_ALL_ON)
        `uvm_field_int(CacheWe, UVM_ALL_ON)
        `uvm_field_int(ByteEnable, UVM_ALL_ON)
        `uvm_field_int(Stall, UVM_ALL_ON)
        `uvm_field_int(MemWriteData, UVM_ALL_ON)
        `uvm_field_int(MemWe, UVM_ALL_ON)
        `uvm_field_int(DataOut, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "CacheItem");
        super.new(name);
    endfunction
    
endclass