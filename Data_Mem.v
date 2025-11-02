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
    input [5:0] addr,       // alu_result[7:2]
    input [31:0] data_in,       // rs2
    input [2:0] byte_select,
    output [31:0] data_out
);

    reg [31:0] mem [0:63];
    wire [31:0] data_read;

    assign data_read = mem[addr];

    if (MemRead) begin
        if (byte_select == 3'b000) begin       // LB
            data_out = {{24{data_read[7]}}, data_read[7:0]};
        end
        else if (byte_select == 3'b001) begin  // LH
            data_out = {{16{data_read[15]}}, data_read[15:0]};
        end
        else if (byte_select == 3'b010) begin  // LW
            data_out = data_read;
        end
        else if (byte_select == 3'b100) begin  // LBU
            data_out = {24'b0, data_read[7:0]};
        end
        else if (byte_select == 3'b101) begin  // LHU
            data_out = {16'b0, data_read[15:0]};
        end
    end
    else 
        32'h00000000;

    always @(posedge clk) begin
        if (MemWrite) begin
            if (byte_select == 3'b000) begin       // SB
                mem[addr][7:0] <= data_in[7:0];
            end
            else if (byte_select == 3'b001) begin  // SH
                mem[addr][15:0] <= data_in[15:0];
            end
            else if (byte_select == 3'b010) begin  // SW
                mem[addr] <= data_in;
            end
        end
    end

    initial begin
        mem[0]=32'd17;
        mem[1]=32'd9;
        mem[2]=32'd25;
    end

endmodule