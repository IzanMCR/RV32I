import cocotb
from cocotb.triggers import Timer
import random
import time

def ByteEnable(random):
    if random == 0b0001:
        return 1
    elif random == 0b0011:
        return 3
    else:
        return 0b1111

@cocotb.test()
async def CacheTest(dut):
    """We will test Cache module with 100 operations of each type"""
    
    Clk = Clock(dut.Clk, 20, "ns")
    cocotb.start_soon(Clk.start())
    
    Counter = 0
    
    await RisingEdge(dut.Clk)
    
    dut.Address = random.randint(4)
    
    for i in range(100):
        dut.MemReady = 0 if Counter < 5 else 1
        dut.WriteData = random.randbytes(4) if dut.MemWe else 0
        dut.CacheWe = 1
        for i in range(8):
            dut.MemReadData = random.randbytes(8)
            time.sleep(0.1)
                        
        CacheWe
        ByteEnable
    