/******************************************************************* 
* 
* Module: n_bit_mux4x1.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: N-bit 4x1 Multiplexer
* 
* Change history: 10/29/25 – Created to support 3 input selection for PC source (PC+4, branch target, JAL/JALR target).
*                 11/02/25 – Changed 3x1 to 4x1 mux to support halting of instructions.
*                 
**********************************************************************/ 

module n_bit_mux4x1 #(parameter N = 32)
(
    input [N-1:0] a,
    input [N-1:0] b,
    input [N-1:0] c,
    input [N-1:0] d,
    input [1:0] select,     // PCSrc 2 bits = {take_branch, PCSelect}
    output reg [N-1:0] out
);

always @(*) begin
    case (select)
        2'b00: out = a; // PC + 4
        2'b10: out = b; // Branch target address and JAL 
        2'b01: out = c; // JALR target address
        2'b11: out = d; // Halt (feeding pc current pc, so stays in same instruction and doesn't go on to the next one)
    endcase
end

endmodule