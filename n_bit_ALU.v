/******************************************************************* 
* 
* Module: n_bit_ALU.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: n-bit ALU with zero flag
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor.
*                 10/28/25 – Added the R-type instruction operations and implemented their functionality, and adding the flags for the B-type format.
*                 
**********************************************************************/ 

module n_bit_ALU #(parameter N = 32) // with zero flag
(
    input [N-1:0] A,    // rs1
    input [N-1:0] B,    // rs2 or immediate
    input [3:0] select,     // ALU selection signal
    output reg [N-1:0] result,
    output zero_flag,
    output carry_flag,
    output overflow_flag,
    output sign_flag
);

    wire [N-1:0] result_rca;
    wire [N-1:0] B_rca;
    wire cin_rca;
    wire cout_rca;

    always @(*) begin
        case (select)
            4'b0000: // AND
                result = A & B; 
            4'b0001: // OR
                result = A | B;
            4'b0010: // ADD
                result = result_rca;
            4'b0110: // SUB
                result = result_rca;
            4'b0011: // SLL
                result = A << B[4:0];
            4'b0100: // SLT
                result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;
            4'b0101: // SLTU
                result = ($unsigned(A) < $unsigned(B)) ? 32'd1 : 32'd0;
            4'b0111: // XOR
                result = A ^ B;
            4'b1000: // SRL
                result = A >> B[4:0];
            4'b1001: // SRA
                result = $signed(A) >>> B[4:0];
            // 4'b1010: // LUI
            //     result = {B[19:0], 12'b0};
            // 4'b1011: // AUIPC
            //     result = A + {B[19:0], 12'b0};
            // 4'b1100: // JAL/JALR
            //     result = A + 32'd4;
//            4'b1111: // Halt
//                result = ;  
        endcase
    end

    assign B_rca = (select[2] == 1) ? ~B : B;
    assign cin_rca = (select[2] == 1) ? 1 : 0;

    RCA #(.N(32)) rca(.A(A), .B(B_rca), .cin(cin_rca), .sum(result_rca), .cout(cout_rca));

    assign zero_flag = ~| result;
    assign carry_flag = cout_rca;
    assign sign_flag = result[N-1];
    assign overflow_flag = (select == 4'b0010) ?
                           ((A[N-1] == B[N-1]) && (result[N-1] != A[N-1])) :
                           (select == 4'b0110) ?
                           ((A[N-1] != B[N-1]) && (result[N-1] != A[N-1])) :
                           1'b0;    

endmodule