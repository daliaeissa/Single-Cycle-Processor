/******************************************************************* 
* 
* Module: mux2x1.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: 2x1 Multiplexer
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor
*                 
**********************************************************************/ 

module mux2x1
(
    input a,
    input b,
    input select,
    output out
);

    assign out = (select == 0) ? a : b;

endmodule