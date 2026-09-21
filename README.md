# 5-Stage Pipelined RISC-V Processor

A Verilog-based implementation of a **5-stage pipelined RISC-V processor** based on the **RV32I instruction set architecture**.

## Overview

This project focuses on the design and implementation of a five-stage pipelined RISC-V processor for low-complexity and energy-constrained applications.

The processor is divided into the following five pipeline stages:

- **IF** – Instruction Fetch
- **ID** – Instruction Decode
- **EX** – Execute
- **MEM** – Memory Access
- **WB** – Write Back

### Pipeline Architecture

```text
        ┌─────┐    ┌─────┐    ┌─────┐    ┌─────┐    ┌─────┐
        │  IF │ →  │  ID │ →  │ EX  │ →  │ MEM │ →  │ WB  │
        └─────┘    └─────┘    └─────┘    └─────┘    └─────┘
Features
- RV32I-based RISC-V processor
- Five-stage instruction pipeline
- Verilog RTL implementation
- Arithmetic and logical operations
- 32-register register file
- Immediate generation
- Instruction decoding
- Instruction memory
- Data memory
- Branch and jump handling
- Pipeline registers
- Data forwarding
- Load-use hazard detection
- Branch decision logic

Pipeline Stages
1. Instruction Fetch (IF)
The program counter is used to fetch instructions from instruction memory.
The PC is normally incremented to point to the next instruction.
2. Instruction Decode (ID)
The fetched instruction is decoded and the required control signals are generated.
The register file is accessed and immediate values are generated according to the instruction format.
3. Execute (EX)
The ALU performs arithmetic and logical operations.
This stage also handles:
- ALU operations
- Operand selection
- Branch condition evaluation
- Branch target calculation
- Data forwarding
4. Memory Access (MEM)
This stage performs read and write operations with the data memory for load and store instructions.
5. Write Back (WB)
The result from either the ALU or data memory is written back into the register file.
Hazard Handling
Pipeline hazards are handled using dedicated hardware units.
Data Forwarding
The forwarding unit detects data dependencies between instructions in different pipeline stages.
Instead of waiting for the result to be written back to the register file, the required value can be forwarded directly to the EX stage.
This helps reduce unnecessary pipeline stalls.
Load-Use Hazard Detection
A load-use hazard occurs when an instruction immediately following a load instruction requires the loaded data.
The hazard detection unit identifies this dependency and introduces the required pipeline stall to maintain correct execution.

5-STAGE-PIPELINED-RISCV/
│
├── README.md
│
├── sources_1/
│   └── new/
│       ├── alu.v
│       ├── alu_con.v
│       ├── ALUSrc_A_MUX.v
│       ├── ALUSrc_B_MUX.v
│       ├── branch_logic.v
│       ├── branch_target.v
│       ├── control_unit.v
│       ├── data_memory.v
│       ├── ex_mem_reg.v
│       ├── forwardA_MUX.v
│       ├── forwardB_MUX.v
│       ├── forwarding_unit.v
│       ├── hazard_unit.v
│       ├── id_ex_reg.v
│       ├── if_id_reg.v
│       ├── immediate_generator.v
│       ├── instruction.mem
│       ├── instruction_decoder.v
│       ├── instruction_memory.v
│       ├── jump_target_MUX.v
│       ├── mem_wb_reg.v
│       ├── MemtoReg_MUX.v
│       ├── pc.v
│       ├── pc_adder.v
│       ├── pc_mux.v
│       ├── pipeline_datapath.v
│       ├── register_file.v
│       └── top.v
│
└── sim_1/
    └── new/
        └── test_bench.v

Main Modules
Module	Description
top.v	Top-level processor module
pipeline_datapath.v	Main pipelined datapath
alu.v	Arithmetic and logical operations
alu_con.v	ALU control logic
control_unit.v	Generates processor control signals
register_file.v	RISC-V register file
instruction_memory.v	Instruction memory
data_memory.v	Data memory
immediate_generator.v	Generates immediate values
instruction_decoder.v	Decodes RISC-V instructions
forwarding_unit.v	Handles data forwarding
hazard_unit.v	Detects load-use hazards
if_id_reg.v	IF/ID pipeline register
id_ex_reg.v	ID/EX pipeline register
ex_mem_reg.v	EX/MEM pipeline register
mem_wb_reg.v	MEM/WB pipeline register
branch_logic.v	Branch decision logic
branch_target.v	Calculates branch target address

Instruction Set
The processor is designed around the RV32I base integer instruction set.
The implementation includes support for instruction categories such as:
- R-type instructions
- I-type instructions
- Load instructions
- Store instructions
- Branch instructions
- Jump instructions
- Immediate arithmetic and logical operations
Complete instruction verification is part of the ongoing development of the processor.
Verification
A Verilog testbench is included for functional verification.
Testbench:
sim_1/new/test_bench.v
The design can be simulated using Xilinx Vivado.
Verification involves checking:
- ALU operations
- Register operations
- Memory operations
- Branch operations
- Pipeline operation
- Forwarding logic
- Hazard detection
- Instruction execution
Tools and Technologies
- Verilog HDL
- Xilinx Vivado
- Git
- GitHub
- RISC-V ISA
Current Status
Implemented
- RV32I processor datapath
- Five-stage pipeline
- ALU
- Register file
- Control unit
- Immediate generator
- Instruction decoder
- Instruction memory
- Data memory
- Pipeline registers
- Data forwarding
- Load-use hazard detection
- Branch logic
Future Work
- Complete verification of all RV32I instructions
- Branch prediction
- CPI measurement
- Performance comparison with and without branch prediction
- FPGA implementation
- Resource utilization analysis
- Power consumption analysis
- Further pipeline optimization
Project Objective
The objective of this project is to design and implement a five-stage pipelined RISC-V processor core with efficient hazard handling and low implementation complexity.
The project focuses on understanding:
- Processor microarchitecture
- Instruction pipelining
- Pipeline hazards
- Data forwarding
- Hazard detection
- Branch handling
- RISC-V instruction execution
- RTL design and verification
Future Development
The processor will be further enhanced with branch prediction and performance evaluation.
The performance of the processor will be analyzed using metrics such as:
- Clock cycles
- CPI (Cycles Per Instruction)
- Pipeline stalls
- Branch penalties
- Execution efficiency
Author
Sathiya Naarayanan C.
Electronics and Communication Engineering
SSN College of Engineering
