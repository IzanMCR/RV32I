# RV32I Superscalar Processor (Work in Progress)

A replication of the RV32I processor architecture, developed as a continuous educational journey into advanced digital design and computer architecture. 

Written primarily in SystemVerilog, this project documents my learning process. As my understanding deepens, the modules are constantly evolving from a basic core towards a more complex, superscalar, and out-of-order execution design.

## Architecture & Current Development

Since this is an educational work-in-progress, many modules are actively being adapted for advanced features. Current and planned implementations include:

*   **Superscalar & OoO Ambitions:** The datapath is being structured to support advanced instruction execution, including the implementation of a Reorder Buffer (ROB) and Reservation Stations.
*   **Advanced Branch Prediction:** The branch predictor is currently in progress. The ultimate goal is to implement a highly accurate **TAGE predictor**.
*   **Cache Memory System:** Designing a Harvard architecture with separate Data and Instruction caches. The target configuration is a 2-way set associative cache with 32 sets, utilizing an LRU (Least Recently Used) replacement policy.
*   **Real Hardware Target:** The design is grounded in physical hardware constraints. Memory management modules, such as `mem_burst` and the `RAMController`, are directly adapted from test modules for the **ALINX AX7035B FPGA** development board.

## Testing and Verification

Hardware verification is being driven by Python using **cocotb**. The testing environment is currently in its early stages but growing alongside the modules. 

Current unit tests cover essential datapath components:
*   ALU Validation (`ALUTest.py`)
*   Register File Validation (`RegFileTest.py`)

## Memory Information & Exceptions

The RISC-V architecture states that we need to manage misaligned memory addresses. Since the processor is supposed to work with an Operating System, I implemented a flag called **MisalignedException**. 

In a real system, when this flag is active, it triggers a trap to the OS. However, as this CPU is created for educational purposes, asserting this flag will also set the **Stall** signal to 1. This halts the processor, mimicking a real error state. Therefore, please do not attempt to execute Store instructions with misaligned addresses in this environment.

*README was created with AI help.*