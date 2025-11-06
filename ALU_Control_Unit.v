/******************************************************************* 
* 
* Module: ALU_Control_Unit.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: ALU control unit
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor.
*                 10/28/25 – Added the R-type instruction decoding based on funct3 and funct7 fields and assigned the ALU selection signals for each operation.
*                 10/29/25 – Added byte_select output to support different load/store sizes.
*                          – Updated ALU selection logic to include I-type instructions.
*                 11/02/25 – Added handling for LUI, AUIPC, JAL, JALR, and halting instructions in the ALU control logic.
*                 
**********************************************************************/ 

module ALU_Control_Unit 
(
    input [1:0] ALUOp,
    input [31:0] instruction,
    output reg [3:0] ALU_selection,
    output reg [2:0] byte_select
);

always @(*) begin
    case (ALUOp)
        2'b00: begin     // Load or Store
            ALU_selection = 4'b0010;    // ADD
            case (instruction[14:12])
                3'b000: byte_select = 3'b000;   // LB or SB
                3'b001: byte_select = 3'b001;   // LH or SH
                3'b010: byte_select = 3'b010;   // LW or SW
                3'b100: byte_select = 3'b100;   // LBU
                3'b101: byte_select = 3'b101;   // LHU
            endcase
        end
        2'b01: begin     // Branch
            ALU_selection = 4'b0110;    // SUB
        end
        2'b10: begin     // R-type or I-type 
            case (instruction[6:0])
                7'b0010011: begin   // I-type : ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
                    case (instruction[14:12])
                        3'b000: begin
                            ALU_selection = 4'b0010;    // ADDI
                        end
                        3'b010: begin
                            ALU_selection = 4'b0100;    // SLTI
                        end
                        3'b011: begin
                            ALU_selection = 4'b0101;    // SLTIU
                        end
                        3'b100: begin
                            ALU_selection = 4'b0111;    // XORI
                        end
                        3'b110: begin
                            ALU_selection = 4'b0001;    // ORI
                        end
                        3'b111: begin
                            ALU_selection = 4'b0000;    // ANDI
                        end
                        3'b001: begin
                            ALU_selection = 4'b0011;    // SLLI
                        end
                        3'b101: begin
                            if (instruction[30] == 1'b0) begin
                                ALU_selection = 4'b1000;    // SRLI
                            end
                            else    // instruction[30] == 1'b1;  
                                ALU_selection = 4'b1001;    // SRAI
                        end
                    endcase
                end
                7'b0110011: begin   // R-type : ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU
                    case (instruction[14:12])
                        3'b000: begin
                            if (instruction[30] == 1'b0) begin
                                ALU_selection = 4'b0010;    // ADD
                            end
                            else begin  // instruction[30] == 1'b1;
                                ALU_selection = 4'b0110;    // SUB
                            end
                        end
                        3'b001: begin
                            ALU_selection = 4'b0011;    // SLL
                        end
                        3'b010: begin
                            ALU_selection = 4'b0100;    // SLT
                        end
                        3'b011: begin
                            ALU_selection = 4'b0101;    // SLTU
                        end
                        3'b100: begin
                            ALU_selection = 4'b0111;    // XOR
                        end
                        3'b101: begin
                            if (instruction[30] == 1'b0) begin
                                ALU_selection = 4'b1000;    // SRL
                            end
                            else    // instruction[30] == 1'b1;  
                                ALU_selection = 4'b1001;    // SRA
                        end
                        3'b110: begin
                            ALU_selection = 4'b0001;    // OR
                        end
                        3'b111: begin
                            ALU_selection = 4'b0000;    // AND
                        end
                    endcase
                end
            endcase
        end
        2'b11: begin    
            case (instruction[6:2])
                5'b01101:    // LUI
                    ALU_selection = 4'b1010;    
                5'b00101:    // AUIPC
                    ALU_selection = 4'b0010;    
                5'b11011:    // JAL
                    ALU_selection = 4'b0010;
                5'b11001:    // JALR
                    ALU_selection = 4'b0010;
                5'b00011:    // FENCE, FENCE.TSO, PAUSE
                    ALU_selection = 4'b1111;   // Halt 
                5'b11100:    // ECALL, EBREAK
                    ALU_selection = 4'b1111;   // Halt
            endcase
        end
    endcase
end

endmodule 