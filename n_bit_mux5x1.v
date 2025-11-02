/******************************************************************* 
* 
* Module: n_bit_mux5x1.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: N-bit 5x1 Multiplexer
* 
* Change history: 11/02/25 – Created to support 5 input selection for the mem to reg mux in the Single Cycle Processor to write in the register file.
*                 
**********************************************************************/ 

module n_bit_mux5x1 #(parameter N = 32)
(
    input [N-1:0] a,
    input [N-1:0] b,
    input [N-1:0] c,
    input [N-1:0] d,
    input [N-1:0] e,
    input [2:0] select,     
    output reg [N-1:0] out
);

always @(*) begin
    case (select)
        3'b000: out = a; 
        3'b001: out = b; 
        3'b010: out = c; 
        3'b011: out = d;
        3'b100: out = e;
    endcase
end

endmodule