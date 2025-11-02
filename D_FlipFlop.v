/******************************************************************* 
* 
* Module: D_FlipFlop.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: D Flip Flop
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor
*                 
**********************************************************************/ 

module D_FlipFlop
(   input clk, 
    input rst, 
    input D, 
    output reg Q);

    always @ (posedge clk or posedge rst)
        if (rst) begin
            Q <= 1'b0;
        end else begin
            Q <= D;
    end
endmodule