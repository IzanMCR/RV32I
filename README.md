
# RV32I Processor

A replication of the RV32I processor. This project contains the design, testing, and performance measurements.

### Memory Information

The RISC-V architecture states that we need to manage misaligned memory addresses. Since the processor is supposed to work with an Operating System, I implemented a flag called **MisalignedException**. In a real system, when this flag is active, it triggers a trap to the OS. However, as this CPU is created for educational purposes, asserting this flag will also set the **Stall** signal to 1. This halts the processor, mimicking a real error state. Therefore, please do not attempt to execute Store instructions with misaligned addresses in this environment.