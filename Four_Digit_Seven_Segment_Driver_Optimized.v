/******************************************************************* 
* 
* Module: Four_Digit_Seven_Segment_Driver_Optimized.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Four Digit Seven Segment Driver Optimized
* 
* Change history: 10/21/25 – Took the file from previous labs to integrate it in the Single Cycle Processor
*                 
**********************************************************************/ 

module Four_Digit_Seven_Segment_Driver_Optimized (
    input clk,
    input [7:0] num,
    output reg [3:0] Anode,
    output reg [6:0] LED_out
    );
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter = 0; // 20-bit counter
    wire [1:0] LED_activating_counter;
    wire [12:0] number;
    wire [12:0] extended_number;
    wire [3:0] Thousands;
    wire [3:0] Hundreds;
    wire [3:0] Tens;
    wire [3:0] Ones;

    assign number = {{5{num[7]}}, num};
    assign extended_number = (number[12] == 1) ? (~number + 1): number;

    BCD shifter(extended_number, Thousands, Hundreds, Tens, Ones);

    always @(posedge clk)
    begin
        refresh_counter <= refresh_counter + 1;
    end

    assign LED_activating_counter = refresh_counter[19:18];

    always @(*)
    begin
        case(LED_activating_counter)
            2'b00: begin
                Anode = 4'b0111;
                if (number[12] == 1) begin
                    LED_BCD = 4'b1010;
                end
                else 
                    LED_BCD = 4'b1011;
            end
            2'b01: begin
                Anode = 4'b1011;
                LED_BCD = Hundreds;
            end
            2'b10: begin
                Anode = 4'b1101;
                LED_BCD = Tens;
            end
            2'b11: begin
                Anode = 4'b1110;
                LED_BCD = Ones;
            end
        endcase
    end

    always @(*)
    begin
        case(LED_BCD)
            4'b0000: LED_out = 7'b0000001; // "0"
            4'b0001: LED_out = 7'b1001111; // "1"
            4'b0010: LED_out = 7'b0010010; // "2"
            4'b0011: LED_out = 7'b0000110; // "3"
            4'b0100: LED_out = 7'b1001100; // "4"
            4'b0101: LED_out = 7'b0100100; // "5"
            4'b0110: LED_out = 7'b0100000; // "6"
            4'b0111: LED_out = 7'b0001111; // "7"
            4'b1000: LED_out = 7'b0000000; // "8"
            4'b1001: LED_out = 7'b0000100; // "9"
            4'b1010: LED_out = 7'b1111110; // "-"
            4'b1011: LED_out = 7'b0000000;
            default: LED_out = 7'b0000001; // "0"
        endcase
    end
endmodule