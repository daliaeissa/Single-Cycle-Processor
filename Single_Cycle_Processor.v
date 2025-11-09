/******************************************************************* 
* 
* Module: Single_Cycle_Processor.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Single Cycle Processor
* 
* Change history: 10/21/25 – Created the module to integrate files to make the Single Cycle Processor.
*                 10/29/25 – Integrated Branch Control Unit to determine when to take a branch based on ALU flags and the different branch types.
*                          – Modified PC mux and selection logic to accommodate JAL and JALR instructions.
*                 11/02/25 – Integrated 5x1 MemtoReg mux to support more data sources to write back to the register file, but need to adjust the control signal MemtoReg to fit the selection line.
*                          – Modified PC mux to be a 4x1 mux to support halting of instructions.   
*                          – Instructions left to modify are AUIPC (check the shifting where it will be done), JAL/JALR (check ALU control unit and ALU for the addition of PC + 4 to be written back to the register file).
*                 11/03/25 – Fixed AUIPC immediate generation to account for the shift left operation, and checked JAL/JALR writeback to register file.
*                          – Single Cycle Processor is now complete and just needs to be tested thoroughly.
*                 
**********************************************************************/ 

module Single_Cycle_Processor 
(
    input clk,
    input ssd_clk,
    input reset,
    input [1:0] ledSel,
    input [3:0] ssdSel,
    output reg [15:0] ledOut,
    output [6:0] ssdOut,
    output [3:0] Anode
);

// PC wires
wire [31:0] pc_current;
wire [31:0] pc_next;

wire [31:0] instruction;

// RF wires
wire [31:0] read_data_1;
wire [31:0] read_data_2;
wire [31:0] RF_write_data;

// Control unit wires
wire Branch;
wire MemRead;
wire [2:0] MemtoReg;
wire [1:0] ALUOp;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire PCSelect;      // Added to know whether to select JAL, JALR
wire [1:0] PCSrc;       // Added to select the next PC source

// ImmGen wires
wire [31:0] immediate;

// ALU wires
wire [3:0] alu_selection;       // ALU control signal
wire [2:0] byte_select;      // For load/store byte selection
wire [31:0] alu_input1;     // rs1
wire [31:0] alu_input2;     // rs2 or immediate
wire [31:0] alu_result;
wire zero_flag;
wire carry_flag;
wire overflow_flag; 
wire sign_flag;
wire take_branch;

// Shift left wires
wire [31:0] shifted_immediate;

// Branch adder wires
wire [31:0] branch_target_address;
wire cout_branch_adder;
wire branch_select;

// PC adder wires
wire [31:0] pc_plus_4;
wire cout_pc_adder;

// Data memory wires
wire [31:0] read_data_mem;

// ALU input mux
assign alu_input1 = read_data_1;        

// Branch logic
assign branch_select = Branch & take_branch;        // Use the take_branch signal from Branch Control Unit

// SSD display number wires
reg [12:0] num_to_display;

n_bit_register #(32) pc (
    .load(1'b1),
    .D(pc_next),
    .clk(clk),
    .rst(reset),
    .Q(pc_current)
);

InstMem inst_mem (
    .addr(pc_current[11:0]),
    .data_out(instruction)
);

register_file RF (
    .RegWrite(RegWrite),
    .write_reg_address(instruction[11:7]), // rd
    .read_reg_address_1(instruction[19:15]), // rs1
    .read_reg_address_2(instruction[24:20]), // rs2
    .write_data(RF_write_data),
    .clk(clk),
    .reset(reset),
    .read_out_1(read_data_1),
    .read_out_2(read_data_2)
);

Control_Unit CU(
    .instruction(instruction),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .PCSelect(PCSelect)
);

Immediate_Generator imm_gen (
    .inst(instruction),
    .gen_out(immediate)
);

ALU_Control_Unit ALU_CU (
    .ALUOp(ALUOp),
    .instruction(instruction),
    .ALU_selection(alu_selection),
    .byte_select(byte_select)
);

n_bit_mux2x1 #(32) alu_src_mux (
    .a(read_data_2),
    .b(immediate),
    .select(ALUSrc),
    .out(alu_input2)
);

n_bit_ALU #(32) ALU (
    .A(alu_input1),     // rs1
    .B(alu_input2),     // rs2 or immediate
    .select(alu_selection),
    .result(alu_result),
    .zero_flag(zero_flag),
    .carry_flag(carry_flag),
    .overflow_flag(overflow_flag),
    .sign_flag(sign_flag)   
);

n_bit_shift_left #(32) shift (
    .in(immediate),
    .out(shifted_immediate)
);

RCA #(32) PC_adder (
    .A(pc_current),
    .B(32'd4),
    .cin(1'b0),
    .sum(pc_plus_4),
    .cout(cout_pc_adder)
);

RCA #(32) branch_adder (
    .A(pc_current),
    .B(shifted_immediate),
    .cin(1'b0),
    .sum(branch_target_address),
    .cout(cout_branch_adder)
);

assign PCSrc = {branch_select, PCSelect};

n_bit_mux4x1 pc_mux (
    .a(pc_plus_4),
    .b(branch_target_address), // Add JAL here 
    .c(alu_result),        // JAL/JALR target address // make JALR target address here ALU result
    .d(pc_current),        // Halt
    .select(PCSrc),         // need to change to pc_select to add the lui, auipc, jal, jalr later
    .out(pc_next)
);

Data_Mem data_mem (
    .clk(clk),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .addr(alu_result[11:0]),
    .data_in(read_data_2),
    .byte_select(byte_select),
    .data_out(read_data_mem)
);

n_bit_mux5x1 #(32) mem_to_reg_mux (
    .a(alu_result),
    .b(read_data_mem),
    .c(immediate),
    .d(branch_target_address),    
    .e(pc_plus_4),   
    .select(MemtoReg),
    .out(RF_write_data)
);

Branch_Control_Unit branch_control_unit (
    .zero_flag(zero_flag),
    .carry_flag(carry_flag),
    .overflow_flag(overflow_flag),
    .sign_flag(sign_flag),
    .Branch(Branch),
    .funct3(instruction[14:12]),
    .opcode(instruction[6:0]),
    .take_branch(take_branch)
);

always @(posedge clk) begin
    // LED output selection
    if (ledSel == 2'b00) begin
        ledOut = instruction[15:0];
    end
    else if (ledSel == 2'b01) begin
        ledOut = instruction[31:16];
    end
    else if (ledSel == 2'b10) begin
        ledOut = {2'b00, Branch, MemtoReg, ALUOp, MemWrite, MemRead, ALUSrc, RegWrite, alu_selection, zero_flag, branch_select};
    end

    // SSD output selection
    if (ssdSel == 4'b0000) begin
        num_to_display = pc_current[12:0];
    end
    else if (ssdSel == 4'b0001) begin
        num_to_display = pc_plus_4[12:0];
    end
    else if (ssdSel == 4'b0010) begin
        num_to_display = branch_target_address[12:0];
    end
    else if (ssdSel == 4'b0011) begin
        num_to_display = pc_next[12:0];
    end
    else if (ssdSel == 4'b0100) begin
        num_to_display = read_data_1[12:0];
    end
    else if (ssdSel == 4'b0101) begin
        num_to_display = read_data_2[12:0];
    end
    else if (ssdSel == 4'b0110) begin
        num_to_display = RF_write_data[12:0];
    end
    else if (ssdSel == 4'b0111) begin
        num_to_display = immediate[12:0];
    end
    else if (ssdSel == 4'b1000) begin
        num_to_display = shifted_immediate[12:0];
    end
    else if (ssdSel == 4'b1001) begin
        num_to_display = alu_input2[12:0];
    end
    else if (ssdSel == 4'b1010) begin
        num_to_display = alu_result[12:0];
    end
    else if (ssdSel == 4'b1011) begin
        num_to_display = read_data_mem[12:0];
    end
end

Four_Digit_Seven_Segment_Driver_Optimized ssd_driver (
    .clk(ssd_clk),
    .num(num_to_display),
    .Anode(Anode),
    .LED_out(ssdOut)
);

endmodule