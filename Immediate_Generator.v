/******************************************************************* 
* 
* Module: Immediate_Generator.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Immediate Generator
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor
*                 10/29/25 – Modified to handle immediate generation for LUI, AUIPC, JAL, and JALR instructions (Not fully done yet and needs checking still).
*                 11/02/25 – Fixed immediate generation for all instruction types including LUI, AUIPC, JAL, and JALR.
*                          – Added handling for unsigned immediates in load and branch instructions.
*                 
**********************************************************************/ 

module Immediate_Generator 
(
    input [31:0] inst,
    output [31:0] gen_out
);

reg [19:0] immediate;

always @(*) begin
    // if (inst[6:5] == 2'b00) begin    // LW bits 6 & 5 00 
    //     immediate = inst[31:20];
    // end
    // else if (inst[6:5] == 2'b01) begin   // SW bits 6 & 5 01
    //     immediate = {inst[31:25], inst[11:7]};
    // end
    // else if (inst[6:5] == 2'b11) begin   // BEQ bits 6 & 5 11
    //     immediate = {inst[31], inst[7], inst[30:25], inst[11:8]};
    // end
    case (inst[6:0]) 
        7'b0110111: begin // LUI
            immediate = inst[31:12]; 
            gen_out = {immediate, 12'b0};
        end
        7'b0010111: begin // AUIPC
            immediate = inst[31:12]; 
            gen_out = {immediate, 12'b0};
        end
        7'b1101111: begin // JAL
            immediate = {8{1'b0}, inst[31], inst[19:12], inst[20], inst[30:21]};     // Didn't add 0 at the end here because it's handled in the shift left module
            gen_out = {12{immediate[19]}, immediate};                      // Didn't add 0 at the end here because it's handled in the shift left module
        end
        7'b1100111: begin // JALR
            immediate = {8{1'b0}, inst[31:20]};    // Filling the upper bits with zeros because no bits for the immmediate to fill them because immediate is only 12 bits
            gen_out = {20{immediate[11]}, immediate[11:0]};
        end
        7'b1100011: begin // BEQ, BNE, BLT, BGE, BLTU, BGEU
            immediate = {8{1'b0}, inst[31], inst[7], inst[30:25], inst[11:8]};   // Filling the upper bits with zeros because no bits for the immmediate to fill them because immediate is only 13 bits
            case (inst[14:12])
                3'110, 3'111: begin // BGEU, BLTU
                    gen_out = {20{1'b0}, immediate}; // Zero extend for unsigned comparison
                end
                default: begin
                    // sign-extend for signed comparison
                    gen_out = {20{immediate[11]}, immediate};
                end
            endcase
        end
        7'b0000011: begin // LB, LH, LW, LBU, LHU
            immediate = {8{1'b0}, inst[31:20]};     // Filling the upper bits with zeros because no bits for the immmediate to fill them because immediate is only 12 bits

            case (inst[14:12])
                3'b100, 3'b101: begin // LBU, LHU
                    gen_out = {20{1'b0}, immediate[11:0]}; // Zero extend for unsigned load
                end
                default: begin
                    // sign-extend for signed load
                    gen_out = {20{immediate[11]}, immediate[11:0]};
                end 
            endcase
        end
        7'b0100011: begin // SB, SH, SW
            immediate = {8{1'b0}, inst[31:25], inst[11:7]};     // Filling the upper bits with zeros because no bits for the immmediate to fill them because immediate is only 12 bits
            gen_out = {20{immediate[11]}, immediate[11:0]};
        end
        7'b0010011: begin // I-type ALU operations: ADDI, ANDI, ORI, XORI, SLLI, SRLI, SRAI, SLTI, SLTIU
            immediate = {8{1'b0}, inst[31:20]};     // Filling the upper bits with zeros because no bits for the immmediate to fill them because immediate is only 12 bits

            case (inst[14:12])
                3'b001, 3'b101: begin // SLLI, SRLI, SRAI
                    
                end
                3'b011: begin // SLTIU
                    gen_out = {20{1'b0}, immediate[11:0]}; // Zero extend for unsigned comparison
                end
                default: begin
                    // sign-extend for signed operations
                    gen_out = {20{immediate[11]}, immediate[11:0]};
                end
            endcase
        end
        7'b0110011: begin // R-type ALU operations: ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU
            immediate = 12'b0; // No immediate for R-type
            gen_out = 32'b0;
        end
    endcase
end

// assign gen_out = {{20{immediate[11]}}, immediate[11:0]}; 


endmodule