/******************************************************************* 
* 
* Module: FA.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Full Adder
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor
*                 
**********************************************************************/ 

module FA (
    input A,
    input B,
    input cin,
    output sum,
    output cout
);

    assign {cout, sum} = A + B + cin;

endmodule 