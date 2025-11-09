/******************************************************************* 
* 
* Module: Branch_Control_Unit.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Branch Control Unit
* 
* Change history: 10/28/25 – File created to differentiate branch control logic and to know when to take a branch (but this still needs to be integrated in the full single cycle processor).
*                 11/09/25 – updated to fix the jal branching 
*                 
**********************************************************************/ 

module Branch_Control_Unit
(
    input zero_flag,
    input carry_flag,
    input overflow_flag,
    input sign_flag,
    input Branch,
    input [2:0] funct3,
    input [6:0] opcode,
    output take_branch
);

    wire beq, bne, blt, bge, bltu, bgeu, jal, fence_pause, ecall_ebreak;

    assign beq  = (funct3 == 3'b000) ? 1'b1 : 1'b0;
    assign bne  = (funct3 == 3'b001) ? 1'b1 : 1'b0;
    assign blt  = (funct3 == 3'b100) ? 1'b1 : 1'b0;
    assign bge  = (funct3 == 3'b101) ? 1'b1 : 1'b0;
    assign bltu = (funct3 == 3'b110) ? 1'b1 : 1'b0;
    assign bgeu = (funct3 == 3'b111) ? 1'b1 : 1'b0;
    
    assign jal = (opcode == 7'b1101111) ? 1'b1 : 1'b0;
    assign fence_pause = (opcode == 7'b0001111) ? 1'b1 : 1'b0;
    assign ecall_ebreak = (opcode == 7'b1110011) ? 1'b1 : 1'b0;

    assign take_branch = Branch & (
                            (beq  & zero_flag) |
                            (bne  & ~zero_flag) |
                            (blt  & (sign_flag ^ overflow_flag)) |
                            (bge  & ~(sign_flag ^ overflow_flag)) |
                            (bltu & ~carry_flag) |
                            (bgeu & carry_flag) | (jal) | (fence_pause) | (ecall_ebreak)
                         );

endmodule