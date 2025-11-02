/******************************************************************* 
* 
* Module: Control_Unit.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Control Unit
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor.
*                 10/29/25 – Modified to include control signals for LUI, AUIPC, JAL, and JALR instructions.
*                          – Added PCSelect output to select JAL/JALR.
*                 11/02/25 – Need to update the MemtoReg control signal to accomodate the 5 possibilities of the writeback stage.
*                          – Added control signals for the 5 halting instructions: FENCE, FENCE.TSO, PAUSE, ECALL, EBREAK.
*                 
**********************************************************************/ 

module Control_Unit 
(
    input [31:0] instruction,
    output reg Branch,
    output reg MemRead,
    output reg [2:0] MemtoReg,
    output reg [1:0] ALUOp, 
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg PCSelect      // Output to select from the mux the next PC source
);

always @(*) begin
    case(instruction[6:2])
        5'b01100: begin     // R-type : ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU
            Branch = 0;
            MemRead = 0;
            MemtoReg = 3'b000;
            ALUOp = 2'b10;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 1;
            PCSelect = 0;
        end
        5'b00000: begin     // Load : LB, LH, LW, LBU, LHU, 
            Branch = 0;
            MemRead = 1;
            MemtoReg = 3'b001;
            ALUOp = 2'b00;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            PCSelect = 0;
        end
        5'b01000: begin     // Store : SB, SH, SW
            Branch = 0;
            MemRead = 0;
            MemtoReg = 3'bXXX;
            ALUOp = 2'b00;
            MemWrite = 1;
            ALUSrc = 1;
            RegWrite = 0;
            PCSelect = 0;
        end
        5'b11000: begin     // B-type : BEQ, BNE, BLT, BGE, BLTU, BGEU
            Branch = 1;
            MemRead = 0;
            MemtoReg = 3'bXXX;
            ALUOp = 2'b01;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            PCSelect = 0;
        end
        5'b00100: begin     // I-type : ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
            Branch = 0;
            MemRead = 0;
            MemtoReg = 3'b000;
            ALUOp = 2'b10;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            PCSelect = 0;
        end
        5'b01101: begin     // LUI
            Branch = 0;
            MemRead = 0;
            MemtoReg = 3'b010;
            ALUOp = 2'b11;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            PCSelect = 0;
        end
        5'b00101: begin     // AUIPC
            Branch = 0;
            MemRead = 0;
            MemtoReg = 3'b011;
            ALUOp = 2'b11;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            PCSelect = 0;
        end
        5'b11011: begin     // JAL
            Branch = 0;
            MemRead = 0;
            MemtoReg = 3'b100;
            ALUOp = 2'b11;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            PCSelect = 1;
        end
        5'b11001: begin     // JALR
            Branch = 0;
            MemRead = 0;
            MemtoReg = 3'b100;
            ALUOp = 2'b11;
            MemWrite = 0;
            ALUSrc = 1;
            RegWrite = 1;
            PCSelect = 1;
        end
        5'b00011: begin     // FENCE, FENCE.TSO, PAUSE
            Branch = 0;
            MemRead = 0;
            MemtoReg = 3'bXXX;
            ALUOp = 2'b11;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            PCSelect = 0;
        end
        5'b11100: begin     // ECALL, EBREAK
            Branch = 0;
            MemRead = 0;
            MemtoReg = 3'bXXX;
            ALUOp = 2'b11;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            PCSelect = 0;
        end
    endcase
end

endmodule 