/******************************************************************* 
* 
* Module: RCA.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Ripple Carry Adder
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor
*                 
**********************************************************************/ 

module RCA #(parameter N = 8)
(   input [N-1:0] A,
    input [N-1:0] B,
    input cin,
    output [N-1:0] sum,
    output cout
);

    wire [N:0] cout_array;
    assign cout_array[0] = cin;
    genvar i;

    generate 

        for(i = 0;i < N ; i = i + 1) begin
            FA fa(.A(A[i]), .B(B[i]), .cin(cout_array[i]), .sum(sum[i]), .cout(cout_array[i+1]));
        end

        assign cout = cout_array[N];
        
    endgenerate 

endmodule