import cocotb
from cocotb.triggers import Timer
import random

def signedNumber(num):
    if num >= 0x80000000:     
        return num - 0x100000000 
    return num

@cocotb.test()
async def ALUTest(dut):
    """We will test ALU module with 100 operations of each type"""
    
    dut.ALUSelect.value = 0b0000
    
    for _ in range(100):
        ValueA = random.randint(0, 4294967295) 
        ValueB = random.randint(0, 4294967295)
        
        dut.OperandA.value = ValueA
        dut.OperandB.value = ValueB
        
        await Timer(1, units="ns") 
        
       
        ResultExpected = (ValueA + ValueB) % 4294967296 
        
        # El assert es el corazón de la verificación
        assert dut.Result.value == ResultExpected, \
            f"Error: {ValueA} + {ValueB}. Hardware output {dut.Result.value}, Python expect {ResultExpected}"

    dut.ALUSelect.value = 0b0001
    
    for _ in range(100):
        
        ValueA = random.randint(0, 4294967295) 
        ValueB = random.randint(0, 4294967295)
        
        dut.OperandA.value = ValueA
        dut.OperandB.value = ValueB
        
      
        await Timer(1, units="ns") 
        
      
        ResultExpected = (ValueA - ValueB) % 4294967296 
        
        assert dut.Result.value == ResultExpected, \
            f"Error: {ValueA} + {ValueB}. Hardware output {dut.Result.value}, Python expect {ResultExpected}"
    
    dut.ALUSelect.value = 0b0010
    
    for _ in range(100):
        
        ValueA = random.randint(0, 4294967295) 
        ValueB = random.randint(0, 4294967295)
        
        dut.OperandA.value = ValueA
        dut.OperandB.value = ValueB
        
      
        await Timer(1, units="ns") 
        
      
        ResultExpected = (ValueA & ValueB) % 4294967296 
        
        assert dut.Result.value == ResultExpected, \
            f"Error: {ValueA} and {ValueB}. Hardware output {dut.Result.value}, Python expect {ResultExpected}"
            
    dut.ALUSelect.value = 0b0011
    
    for _ in range(100):
        
        ValueA = random.randint(0, 4294967295) 
        ValueB = random.randint(0, 4294967295)
        
        dut.OperandA.value = ValueA
        dut.OperandB.value = ValueB
        
      
        await Timer(1, units="ns") 
        
      
        ResultExpected = (ValueA | ValueB) % 4294967296 
        
        assert dut.Result.value == ResultExpected, \
            f"Error: {ValueA} or {ValueB}. Hardware output {dut.Result.value}, Python expect {ResultExpected}"
    
    dut.ALUSelect.value = 0b0100
    
    for _ in range(100):
        
        ValueA = random.randint(0, 4294967295) 
        ValueB = random.randint(0, 4294967295)
        
        dut.OperandA.value = ValueA
        dut.OperandB.value = ValueB
        
      
        await Timer(1, units="ns") 
        
      
        ResultExpected = (ValueA ^ ValueB) % 4294967296 
        
        assert dut.Result.value == ResultExpected, \
            f"Error: {ValueA} ^ {ValueB}. Hardware output {dut.Result.value}, Python expect {ResultExpected}"
    
    dut.ALUSelect.value = 0b0101
    
    for _ in range(100):
        
        ValueA = random.randint(0, 4294967295) 
        ValueB = random.randint(0, 4294967295)
        
        dut.OperandA.value = ValueA
        dut.OperandB.value = ValueB
        
      
        await Timer(1, units="ns") 
        
      
        ResultExpected = (ValueA << (ValueB & 0x1F)) % 4294967296 
        
        assert dut.Result.value == ResultExpected, \
            f"Error: {ValueA} << {ValueB}. Hardware output {dut.Result.value}, Python expect {ResultExpected}"
    
    dut.ALUSelect.value = 0b0110
    
    for _ in range(100):
        
        ValueA = random.randint(0, 4294967295) 
        ValueB = random.randint(0, 4294967295)
        
        dut.OperandA.value = ValueA
        dut.OperandB.value = ValueB
        
      
        await Timer(1, units="ns") 
        
      
        ResultExpected = (signedNumber(ValueA) < signedNumber(ValueB)) 
        
        assert dut.Result.value == ResultExpected, \
            f"Error: {ValueA} < {ValueB}. Hardware output {dut.Result.value}, Python expect {ResultExpected}"
    
    dut.ALUSelect.value = 0b0111
    
    for _ in range(100):
        
        ValueA = random.randint(0, 4294967295) 
        ValueB = random.randint(0, 4294967295)
        
        dut.OperandA.value = ValueA
        dut.OperandB.value = ValueB
        
      
        await Timer(1, units="ns") 
        
      
        ResultExpected = ValueA < ValueB
        
        assert dut.Result.value == ResultExpected, \
            f"Error: {ValueA} < {ValueB}. Hardware output {dut.Result.value}, Python expect {ResultExpected}"
    
    dut.ALUSelect.value = 0b1000
    
    for _ in range(100):
        
        ValueA = random.randint(0, 4294967295) 
        ValueB = random.randint(0, 4294967295)
        
        dut.OperandA.value = ValueA
        dut.OperandB.value = ValueB
        
      
        await Timer(1, units="ns") 
        
      
        ResultExpected = (ValueA >> (ValueB & 0x1F)) % 4294967296 
        
        assert dut.Result.value == ResultExpected, \
            f"Error: {ValueA} >> {ValueB}. Hardware output {dut.Result.value}, Python expect {ResultExpected}"

    dut.ALUSelect.value = 0b1001
    
    for _ in range(100):
        
        ValueA = random.randint(0, 4294967295) 
        ValueB = random.randint(0, 4294967295)
        
        dut.OperandA.value = ValueA
        dut.OperandB.value = ValueB
        
      
        await Timer(1, units="ns") 
        
      
        ResultExpected = (signedNumber(ValueA) >> (ValueB & 0x1F)) % 4294967296 
        
        assert dut.Result.value == ResultExpected, \
            f"Error: {ValueA} >> {ValueB}. Hardware output {dut.Result.value}, Python expect {ResultExpected}"
            
            
    dut._log.info("All was good!")
    
    