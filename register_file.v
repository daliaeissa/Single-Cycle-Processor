/******************************************************************* 
* 
* Module: register_file.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Register File
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor
*                 
**********************************************************************/ 

module register_file 
(
    input RegWrite,
    input [4:0] write_reg_address,
    input [4:0] read_reg_address_1,
    input [4:0] read_reg_address_2,
    input [31:0] write_data,
    input clk,
    input reset,
    output [31:0] read_out_1,
    output [31:0] read_out_2
);

reg [31:0] reg_file [31:0];

assign read_out_1 = reg_file[read_reg_address_1];
assign read_out_2 = reg_file[read_reg_address_2];

integer i = 0;

always@(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        for (i = 0; i < 32; i = i + 1) begin
            reg_file[i] = 0;
        end
    end
    else if (RegWrite == 1'b1 && write_reg_address != 0) begin
        reg_file[write_reg_address] = write_data;
    end
end

endmodule 