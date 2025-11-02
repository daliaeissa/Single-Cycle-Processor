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
    output take_branch
);

    wire beq, bne, blt, bge, bltu, bgeu;

    assign beq  = (funct3 == 3'b000) ? 1'b1 : 1'b0;
    assign bne  = (funct3 == 3'b001) ? 1'b1 : 1'b0;
    assign blt  = (funct3 == 3'b100) ? 1'b1 : 1'b0;
    assign bge  = (funct3 == 3'b101) ? 1'b1 : 1'b0;
    assign bltu = (funct3 == 3'b110) ? 1'b1 : 1'b0;
    assign bgeu = (funct3 == 3'b111) ? 1'b1 : 1'b0;

    assign take_branch = Branch & (
                            (beq  & zero_flag) |
                            (bne  & ~zero_flag) |
                            (blt  & (sign_flag ^ overflow_flag)) |
                            (bge  & ~(sign_flag ^ overflow_flag)) |
                            (bltu & ~carry_flag) |
                            (bgeu & carry_flag)
                         );

endmodule