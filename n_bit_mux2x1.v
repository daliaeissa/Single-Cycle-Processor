/******************************************************************* 
* 
* Module: n_bit_mux2x1.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: N-bit 2x1 Multiplexer
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor
*                 
**********************************************************************/ 

module n_bit_mux2x1 #(parameter N = 8)
(
    input [N-1:0] a,
    input [N-1:0] b,
    input select,
    output [N-1:0] out
);

genvar i;
generate
    for(i = 0; i < N; i = i + 1) begin
        mux2x1 mux(.a(a[i]), .b(b[i]), .select(select), .out(out[i]));
    end
endgenerate

endmodule 