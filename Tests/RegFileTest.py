import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer
import random

@cocotb.test()
async def RegFileTest(dut):
    
    Clk = Clock(dut.Clk, 20, "ns")
    cocotb.start_soon(Clk.start())
    
    await RisingEdge(dut.Clk)
    
    for _ in range(100):
        Data = random.randint(0, 4294967295)
        Destination0 = random.randint(1, 31)
        
        dut.Data.value = Data
        
        dut.We.value = 1
        
        dut.Rd.value = Destination0
        
        
        await RisingEdge(dut.Clk)
        
        dut.We.value = 0
        dut.Rs1.value = Destination0
        
        await Timer(1, units="ns")
        
        assert dut.Rs1Out.value == Data, \
            f"Error: Lecture before Write"
    
    for _ in range(100):
        # Apagamos la escritura para esta prueba
        dut.We.value = 0
        
        Destination1 = random.randint(1, 31)
        Destination2 = random.randint(1, 31)
        
        dut.Rs1.value = Destination1
        dut.Rs2.value = Destination2
        
        # Esperamos un pequeño tiempo para la lectura combinacional
        await Timer(1, units="ns")
        
        # Comparamos la salida contra la memoria interna (Caja Blanca)
        assert dut.Rs1Out.value == dut.Rf[Destination1].value, \
            f"Error en Rs1Out con registro {Destination1}"
            
        assert dut.Rs2Out.value == dut.Rf[Destination2].value, \
            f"Error en Rs2Out con registro {Destination2}"
        