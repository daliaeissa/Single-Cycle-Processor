/******************************************************************* 
* 
* Module: Single_Cycle_Processor_tb.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Single Cycle Processor Testbench
* 
* Change history: 10/21/25 – Created the testbench to test the Single Cycle Processor
*                 
**********************************************************************/ 

module Single_Cycle_Processor_tb ();

    reg clk;
    reg reset;

    Single_Cycle_Processor DUT (
        .clk(clk),
        .reset(reset)
    );

    localparam clk_period = 10;

    initial begin
        clk = 0;
        forever #(clk_period/2) clk = ~clk;
    end

    initial begin
        reset = 1;
        #(clk_period);
        reset = 0;
        #(clk_period*100);

        //DUT.pc_next = 0; // Initialize PC to 0

        // Check PC and instruction fetch
        $monitor("Time: %0d, PC: %d, Instruction: %b", $time, DUT.pc_current, DUT.inst_mem.data_out);

        // Check register file operations
        $monitor("Time: %0d, Read Data 1: %d, Read Data 2: %d, Immediate: %d", $time, DUT.read_data_1, DUT.read_data_2, DUT.immediate);

        // Check Control signals
        $monitor("Time: %0d, Branch: %b, MemRead: %b, MemtoReg: %b, ALUOp: %b, MemWrite: %b, ALUSrc: %b, RegWrite: %b", 
                 $time, DUT.Branch, DUT.MemRead, DUT.MemtoReg, DUT.ALUOp, DUT.MemWrite, DUT.ALUSrc, DUT.RegWrite);

        // Check Immediate generation
        $monitor("Time: %0d, Immediate: %d", $time, DUT.immediate);

        // Check ALU control signals
        $monitor("Time: %0d, ALU Selection: %b", $time, DUT.alu_selection);

        // Check alu_src_mux output
        $monitor("Time: %0d, ALU Input 1: %d, ALU Input 2: %d", $time, DUT.alu_input1, DUT.alu_input2);

        // Check ALU operations
        $monitor("Time: %0d, ALU Result: %d, Zero Flag: %b", $time, DUT.alu_result, DUT.zero_flag);

        // Check shift left operation
        $monitor("Time: %0d, Input Immediate: %d, Shifted Immediate: %d", $time, DUT.immediate, DUT.shifted_immediate);

        // Check PC adder output
        $monitor("Time: %0d, PC Current: %d, PC Next: %d", $time, DUT.pc_current, DUT.pc_plus_4);

        // Check Branch adder output
        $monitor("Time: %0d, PC Current: %d, Branch Target Address: %d", $time, DUT.pc_current, DUT.branch_target_address);

        // Check PC MUX output
        $monitor("Time: %0d, PC Next: %d", $time, DUT.pc_next);

        // Check Data Memory operations
        $monitor("Time: %0d, Data Memory Read Data: %d", $time, DUT.read_data_mem);

        // Check mem_to_reg_mux output
        $monitor("Time: %0d, RF Write Data: %d", $time, DUT.RF_write_data);

        $stop;
    end

endmodule