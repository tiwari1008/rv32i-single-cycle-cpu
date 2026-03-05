 # RISC-V (RV32I) Single-Cycle CPU Design

## Project Overview
This project implements a **32-bit single-cycle CPU** based on the RV32I instruction set of the RISC-V architecture using Verilog HDL.  
The processor executes instructions in a single clock cycle through a complete datapath consisting of instruction fetch, decode, execute, memory access, and write-back stages.

The design includes a custom ALU, register file, control unit, and memory modules. Functional verification was performed through waveform simulation using Vivado.

---

## Features
- 32-bit single-cycle processor architecture
- Supports **RV32I instruction set**
- Custom **Arithmetic Logic Unit (ALU)**
- **32 × 32 Register File**
- Immediate value generation for different instruction formats
- Instruction and Data memory modules
- Complete datapath implementation
- Verified using waveform simulation

---

## Supported Instruction Formats

| Type | Description |
|-----|-------------|
| R-Type | Register-to-register arithmetic operations |
| I-Type | Immediate arithmetic and load instructions |
| S-Type | Store instructions |
| B-Type | Conditional branch instructions |
| U-Type | Upper immediate instructions |
| J-Type | Jump instructions |

---

## Processor Architecture

The processor consists of the following modules:

- **Instruction Fetch Unit** – Fetches instructions using the Program Counter  
- **Instruction Memory** – Stores program instructions  
- **Control Unit** – Generates control signals based on opcode  
- **Immediate Generator** – Generates immediate values for different instruction formats  
- **Register File** – 32 general-purpose registers  
- **ALU** – Performs arithmetic and logical operations  
- **Data Memory** – Used for load and store instructions  
- **Datapath** – Connects all modules for instruction execution  

---

## Project File Structure
