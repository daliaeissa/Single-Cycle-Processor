/******************************************************************* 
* 
* Module: n_bit_register.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: N-bit Register
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor
*                 
**********************************************************************/ 

module n_bit_register #(parameter N = 8)
(
    input load,
    input [N-1:0] D,
    input clk,
    input rst, 
    output [N-1:0] Q
);

wire [N-1:0] mux_out;
wire [N-1:0] q;

genvar i;

generate
    for (i = 0; i < N; i = i + 1) begin
        D_FlipFlop dff(.clk(clk), .rst(rst), .D(mux_out[i]), .Q(q[i]));
        mux2x1 mux(.a(q[i]), .b(D[i]), .select(load), .out(mux_out[i]));
    end
endgenerate

    assign Q = q;

endmodule