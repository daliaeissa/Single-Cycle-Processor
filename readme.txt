============================================================
               COMPUTER ARCHITECTURE PROJECT
============================================================

Project Title : RISC-V 32-bit CPU Implementation
Course        : Computer Architecture
Semester      : Fall 2025
Instructor    : Dr Cherif Salama
University    : The American University in Cairo

------------------------------------------------------------
TEAM MEMBERS
------------------------------------------------------------
1. Omar Zainleabideen – 900211544 – omarzee@aucegypt.edu
2. Dalia Eissa – 900212070 – daliaeissa@aucegypt.edu
3. Nour Waleed – 900211139 – nourwaleedmo.k@aucegypt.edu

------------------------------------------------------------
PROJECT OVERVIEW
------------------------------------------------------------
This project implements a 32-bit RISC-V CPU capable of executing a
subset of the RV32I instruction set. The design includes an ALU,
register file, control unit, immediate generator, instruction memory,
data memory, and PC update logic.

Simulation and verification were performed using Vivado. The CPU was tested using a variety of programs to validate arithmetic, logic, memory, branch, and system instructions.

------------------------------------------------------------
SUPPORTED INSTRUCTIONS
------------------------------------------------------------
• Arithmetic & Logic (R-type):
  ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
• Immediate Arithmetic & Logic (I-type):
  ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
• Load Instructions (I-type):
  LB, LH, LW, LBU, LHU
• Store Instructions (S-type):
  SB, SH, SW
• Branch Instructions (B-type):
  BEQ, BNE, BLT, BGE, BLTU, BGEU
• Jump Instructions (J-type & I-type):
  JAL, JALR
• Upper Immediate Instructions (U-type):
  LUI, AUIPC
• System & Environment Instructions:
  ECALL, EBREAK, FENCE, PAUSE

------------------------------------------------------------
ASSUMPTIONS
------------------------------------------------------------
• Instruction memory and data memory are word-addressed.
• PC increments by 4 for each instruction unless a branch/jump occurs.
• CPU starts execution from address 0x00000000.
• ECALL, EBREAK, FENCE, and PAUSE halt execution by stopping the PC at the last value.

------------------------------------------------------------
WHAT WORKS
------------------------------------------------------------
✔ Arithmetic, logic, and shift operations verified
✔ Immediate generator and control unit tested
✔ Branches and jumps validated using test programs
✔ Data memory read/write functional
✔ FENCE, FENCE.TSO, and PAUSE execute without error
✔ ECALL and EBREAK correctly halt execution

------------------------------------------------------------
KNOWN ISSUES / LIMITATIONS
------------------------------------------------------------
• No CSR or exception handling implemented (ECALL/EBREAK halt) - wrong for pipelining
• No pipeline or hazard detection (single-cycle or multi-cycle only)
• No support for compressed (C) or floating-point (F/D) instructions
• Calling test case file to load instructions did not work

------------------------------------------------------------
TEST PROGRAMS
------------------------------------------------------------
1. test1
2. test2
3. test3
4. test4
5. test5
6. test6
7. test7

------------------------------------------------------------
RELEASE NOTES
------------------------------------------------------------
09/11/2025  – Initial release
          - Implemented instruction memory and control unit
          - Added branch and jump logic
          - Basic ALU operations functional



------------------------------------------------------------
FUTURE WORK
------------------------------------------------------------
• Implement pipeline stages and hazard control
• Add support for multiplication/division (RV32M)
• Implement a test generator script

============================================================
END OF README
============================================================


