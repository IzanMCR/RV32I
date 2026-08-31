`include "uvm_macros.svh"
import uvm_pkg::*;

module tb_top;
    logic Clk;
    logic Rst;

    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk;
    end

    initial begin
        Rst = 1;
        #10 Rst = 0;
    end

    CacheInterface vif(Clk, Rst);
  
    Cache dut(
        .Clk(vif.Clk),
        .Rst(vif.Rst),
        .Address(vif.Address),
        .MemReady(vif.MemReady),
        .MemReadData(vif.MemReadData),
        .WriteData(vif.WriteData),
        .CacheWe(vif.CacheWe),
        .ByteEnable(vif.ByteEnable),
        .Stall(vif.Stall),
        .MemWriteData(vif.MemWriteData),
        .MemWe(vif.MemWe),
        .DataOut(vif.DataOut)
    );

    initial begin
        uvm_config_db#(virtual CacheInterface)::set(null, "*", "vif", vif);
        run_test("CacheTest");
    end
    
endmodule