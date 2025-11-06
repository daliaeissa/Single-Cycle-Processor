/******************************************************************* 
* 
* Module: Data_Mem.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Data Memory
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor.
*                 10/29/25 – Modified to support byte, half-word, and word load/store operations.
*                 
**********************************************************************/ 

module Data_Mem
(
    input clk, 
    input MemRead, 
    input MemWrite,
    input [11:0] addr,       // alu_result[7:2]
    input [31:0] data_in,       // rs2
    input [2:0] byte_select,
    output reg [31:0] data_out
);

   // Byte-addressable memory
    reg [7:0] mem [0:4096-1];

    // Convenience wires (little-endian order)
    wire [7:0] b0 = mem[addr + 0];
    wire [7:0] b1 = mem[addr + 1];
    wire [7:0] b2 = mem[addr + 2];
    wire [7:0] b3 = mem[addr + 3];

    // Asynchronous read
    always @(*) begin
        if (MemRead) begin
            case (byte_select)
                3'b000: begin // LB
                    data_out = {{24{b0[7]}}, b0};
                end
                3'b001: begin // LH (assumes addr[0]==0)
                    data_out = {{16{b1[7]}}, b1, b0};
                end
                3'b010: begin // LW (assumes addr[1:0]==2'b00)
                    data_out = {b3, b2, b1, b0};
                end
                3'b100: begin // LBU
                    data_out = {24'b0, b0};
                end
                3'b101: begin // LHU (assumes addr[0]==0)
                    data_out = {16'b0, b1, b0};
                end
                default: begin
                    data_out = 32'h0000_0000;
                end
            endcase
        end else begin
            data_out = 32'h0000_0000;
        end
    end

    // Synchronous write
    always @(posedge clk) begin
        if (MemWrite) begin
            case (byte_select)
                3'b000: begin // SB
                    mem[addr + 0] <= data_in[7:0];
                end
                3'b001: begin // SH (assumes addr[0]==0)
                    mem[addr + 0] <= data_in[7:0];
                    mem[addr + 1] <= data_in[15:8];
                end
                3'b010: begin // SW (assumes addr[1:0]==2'b00)
                    mem[addr + 0] <= data_in[7:0];
                    mem[addr + 1] <= data_in[15:8];
                    mem[addr + 2] <= data_in[23:16];
                    mem[addr + 3] <= data_in[31:24];
                end
                default: /* no write */ ;
            endcase
        end
    end

    // Optional init:
    // integer i;
    // initial for (i=0; i<DATA_BYTES; i=i+1) mem[i] = 8'h00;

endmodule