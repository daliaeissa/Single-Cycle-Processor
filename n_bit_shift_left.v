/******************************************************************* 
* 
* Module: n_bit_shift_left.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: N-bit Shift Left by 1
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor
*                 
**********************************************************************/ 

module n_bit_shift_left #(parameter N = 8)
(
    input [N-1:0] in,
    output [N-1:0] out
);

assign out = {in[N-2:0], 1'b0};

endmodule