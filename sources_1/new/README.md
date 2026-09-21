# RISC-V Single-Cycle Processor

A Verilog HDL implementation of a 32-bit RISC-V single-cycle processor,
designed and simulated using Xilinx Vivado.

## 🚀 Overview

This project implements the datapath and control logic of a RISC-V
single-cycle CPU based on the RV32I instruction set architecture.

The processor includes instruction fetch, instruction decode,
register file, ALU, memory access, branch handling and write-back stages.

## 🏗️ Architecture

The processor consists of:

- Program Counter (PC)
- Instruction Memory
- Instruction Decoder
- Register File
- Immediate Generator
- Control Unit
- ALU Control
- ALU
- Data Memory
- Branch Logic
- Multiplexers
- Next-PC Logic

## 📋 Supported Instructions

| Type | Instructions |
|------|--------------|
| R-Type | ADD, SUB, AND, OR, XOR, SLT |
| I-Type | ADDI, ANDI, ORI, XORI |
| Load | LW |
| Store | SW |
| Branch | BEQ |
| Jump | JAL, JALR |

## 🛠️ Tools

- Verilog HDL
- Xilinx Vivado
- VS Code
- Git
- GitHub
