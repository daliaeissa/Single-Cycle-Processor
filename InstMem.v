/******************************************************************* 
* 
* Module: InstMem.v 
* Project: Single Cycle Processor
* Author: Dalia Eissa, daliaeissa@aucegypt.edu
          Omar Zainelabdeen, omarzee@aucegypt.edu
          Nour Waleed, nourwaleedmo.k@aucegypt.edu
* Description: Instruction Memory
* 
* Change history: 10/21/25 - Took the file from previous labs to integrate it in the Single Cycle Processor
*                 11/03/25 - Modified to a 4KB memory to accommodate larger programs.
*                 11/04/25 - Initialized memory with a sample instructions for ADDI testing. [ADDI tests successful]
*                 
**********************************************************************/ 

module InstMem 
(
    input [11:0] addr, 
    output [31:0] data_out
);
    // reg [31:0] mem [0:63];
    reg[7:0] mem[(4*1024-1):0]; // 4KB memory
    assign data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr+0]};

    initial begin
//            // ADDI instructions test cases
//            // 0x01500593
//            mem[0]  = 8'h93; mem[1]  = 8'h05; mem[2]  = 8'h50; mem[3]  = 8'h01;
//            // 0x02700713
//            mem[4]  = 8'h13; mem[5]  = 8'h07; mem[6]  = 8'h70; mem[7]  = 8'h02;
//            // 0x02100893
//            mem[8]  = 8'h93; mem[9]  = 8'h08; mem[10] = 8'h10; mem[11] = 8'h02;
//            // 0xffb00a13
//            mem[12] = 8'h13; mem[13] = 8'h0a; mem[14] = 8'hb0; mem[15] = 8'hff;
//            // 0x00100b93
//            mem[16] = 8'h93; mem[17] = 8'h0b; mem[18] = 8'h10; mem[19] = 8'h00;
//            // 0x0f000d13
//            mem[20] = 8'h13; mem[21] = 8'h0d; mem[22] = 8'h00; mem[23] = 8'h0f;
//            // 0xfff00e93
//            mem[24] = 8'h93; mem[25] = 8'h0e; mem[26] = 8'hf0; mem[27] = 8'hff;
//            // 0xfff00493
//            mem[28] = 8'h93; mem[29] = 8'h04; mem[30] = 8'hf0; mem[31] = 8'hff;
//            // 0x00f00213
//            mem[32] = 8'h13; mem[33] = 8'h02; mem[34] = 8'hf0; mem[35] = 8'h00;
//            // 0x0f000093
//            mem[36] = 8'h93; mem[37] = 8'h00; mem[38] = 8'h00; mem[39] = 8'h0f;
//            // 0x02700613
//            mem[40] = 8'h13; mem[41] = 8'h06; mem[42] = 8'h70; mem[43] = 8'h02;
//            // 0x01500793
//            mem[44] = 8'h93; mem[45] = 8'h07; mem[46] = 8'h50; mem[47] = 8'h01;
//            // 0x00500913
//            mem[48] = 8'h13; mem[49] = 8'h09; mem[50] = 8'h50; mem[51] = 8'h00;
//            // 0x00300a93
//            mem[52] = 8'h93; mem[53] = 8'h0a; mem[54] = 8'h30; mem[55] = 8'h00;
//            // 0x00200c13
//            mem[56] = 8'h13; mem[57] = 8'h0c; mem[58] = 8'h20; mem[59] = 8'h00;
//            // 0x03300d93
//            mem[60] = 8'h93; mem[61] = 8'h0d; mem[62] = 8'h30; mem[63] = 8'h00;
//            // 0x00100f13
//            mem[64] = 8'h13; mem[65] = 8'h0f; mem[66] = 8'h10; mem[67] = 8'h00;
//            // 0x00100513
//            mem[68] = 8'h13; mem[69] = 8'h05; mem[70] = 8'h10; mem[71] = 8'h00;
//            // 0x0f000293
//            mem[72] = 8'h93; mem[73] = 8'h02; mem[74] = 8'h00; mem[75] = 8'h0f;
//            // 0x0a500113
//            mem[76] = 8'h13; mem[77] = 8'h01; mem[78] = 8'h50; mem[79] = 8'h0a;
            
              // --- ADDI setup ---
mem[0]=8'h93; mem[1]=8'h00; mem[2]=8'h00; mem[3]=8'h0f; // addi x1,  x0, 240
mem[4]=8'h13; mem[5]=8'h01; mem[6]=8'h50; mem[7]=8'h0a; // addi x2,  x0, 165
mem[8]=8'h93; mem[9]=8'h01; mem[10]=8'h00; mem[11]=8'h10; // addi x3,  x0, 0x100
mem[12]=8'h13; mem[13]=8'h02; mem[14]=8'hf0; mem[15]=8'h00; // addi x4,  x0, 15
mem[16]=8'h93; mem[17]=8'h02; mem[18]=8'h00; mem[19]=8'h0f; // addi x5,  x0, 240
mem[20]=8'h13; mem[21]=8'h03; mem[22]=8'hb0; mem[23]=8'hff; // addi x6,  x0, -5
mem[24]=8'h93; mem[25]=8'h03; mem[26]=8'hb0; mem[27]=8'hff; // addi x7,  x0, -5
mem[28]=8'h93; mem[29]=8'h04; mem[30]=8'hf0; mem[31]=8'hff; // addi x9,  x0, -1
mem[32]=8'h13; mem[33]=8'h05; mem[34]=8'h10; mem[35]=8'h00; // addi x10, x0, 1
mem[36]=8'h93; mem[37]=8'h05; mem[38]=8'h50; mem[39]=8'h01; // addi x11, x0, 21
mem[40]=8'h13; mem[41]=8'h06; mem[42]=8'h70; mem[43]=8'h02; // addi x12, x0, 39
mem[44]=8'h13; mem[45]=8'h07; mem[46]=8'h70; mem[47]=8'h02; // addi x14, x0, 39
mem[48]=8'h93; mem[49]=8'h07; mem[50]=8'h50; mem[51]=8'h01; // addi x15, x0, 21
mem[52]=8'h93; mem[53]=8'h08; mem[54]=8'h10; mem[55]=8'h02; // addi x17, x0, 33
mem[56]=8'h13; mem[57]=8'h09; mem[58]=8'h50; mem[59]=8'h00; // addi x18, x0, 5
mem[60]=8'h13; mem[61]=8'h0a; mem[62]=8'hb0; mem[63]=8'hff; // addi x20, x0, -5
mem[64]=8'h93; mem[65]=8'h0a; mem[66]=8'h30; mem[67]=8'h00; // addi x21, x0, 3
mem[68]=8'h13; mem[69]=8'h0b; mem[70]=8'h10; mem[71]=8'h80; // addi x22, x0, -2047
mem[72]=8'h93; mem[73]=8'h0b; mem[74]=8'h10; mem[75]=8'h00; // addi x23, x0, 1

// --- Stores ---
mem[76]=8'h23; mem[77]=8'h2a; mem[78]=8'h20; mem[79]=8'h12; // sw  x2,  308(x0)
mem[80]=8'h23; mem[81]=8'h20; mem[82]=8'h40; mem[83]=8'h0a; // sw  x4,  160(x0)
mem[84]=8'h23; mem[85]=8'h2e; mem[86]=8'h70; mem[87]=8'h0e; // sw  x7,  252(x0)
mem[88]=8'h23; mem[89]=8'h26; mem[90]=8'h10; mem[91]=8'h12; // sw  x1,  300(x0)
mem[92]=8'h23; mem[93]=8'h2c; mem[94]=8'h70; mem[95]=8'h08; // sw  x7,  152(x0)
mem[96]=8'h23; mem[97]=8'h24; mem[98]=8'hb0; mem[99]=8'h0c; // sw  x11, 200(x0)
mem[100]=8'h23; mem[101]=8'h06; mem[102]=8'hf0; mem[103]=8'h13; // sb  x31, 300(x0)
mem[104]=8'h23; mem[105]=8'h17; mem[106]=8'h50; mem[107]=8'h12; // sh  x5,  302(x0)
mem[108]=8'ha3; mem[109]=8'h08; mem[110]=8'h60; mem[111]=8'h12; // sb  x6,  305(x0)
mem[112]=8'h23; mem[113]=8'h1b; mem[114]=8'h60; mem[115]=8'h13; // sh  x22, 310(x0)
mem[116]=8'h23; mem[117]=8'h26; mem[118]=8'hb5; mem[119]=8'h00; // sw  x11, 12(x10)

// --- Loads & ALU immediates ---
mem[120]=8'h03; mem[121]=8'h24; mem[122]=8'h40; mem[123]=8'h13; // lw   x8,  308(x0)
mem[124]=8'h83; mem[125]=8'h26; mem[126]=8'h00; mem[127]=8'h0a; // lw   x13, 160(x0)
mem[128]=8'h03; mem[129]=8'h28; mem[130]=8'hc0; mem[131]=8'h0f; // lw   x16, 252(x0)
mem[132]=8'h83; mem[133]=8'h29; mem[134]=8'hc0; mem[135]=8'h12; // lw   x19, 300(x0)
mem[136]=8'h03; mem[137]=8'h2c; mem[138]=8'h80; mem[139]=8'h09; // lw   x24, 152(x0)
mem[140]=8'h83; mem[141]=8'h2c; mem[142]=8'h80; mem[143]=8'h0c; // lw   x25, 200(x0)
mem[144]=8'h13; mem[145]=8'h0d; mem[146]=8'h00; mem[147]=8'h0f; // addi x26, x0, 240
mem[148]=8'h93; mem[149]=8'h0d; mem[150]=8'h30; mem[151]=8'h03; // addi x27, x0, 51
mem[152]=8'h93; mem[153]=8'h0e; mem[154]=8'hf0; mem[155]=8'hff; // addi x29, x0, -1
mem[156]=8'h13; mem[157]=8'h0f; mem[158]=8'h10; mem[159]=8'h00; // addi x30, x0, 1
mem[160]=8'h93; mem[161]=8'h0f; mem[162]=8'h50; mem[163]=8'h00; // addi x31, x0, 5
mem[164]=8'h13; mem[165]=8'h29; mem[166]=8'hf3; mem[167]=8'hff; // slti x18, x6, -1
mem[168]=8'h93; mem[169]=8'hb9; mem[170]=8'hf3; mem[171]=8'hff; // sltiu x19, x7, -1
mem[172]=8'h13; mem[173]=8'hca; mem[174]=8'hb5; mem[175]=8'h22; // xori x20, x11, 555
mem[176]=8'h93; mem[177]=8'hea; mem[178]=8'h56; mem[179]=8'h06; // ori  x21, x13, 101
mem[180]=8'h13; mem[181]=8'hfb; mem[182]=8'hd7; mem[183]=8'h14; // andi x22, x15, 333
mem[184]=8'h93; mem[185]=8'h1b; mem[186]=8'h58; mem[187]=8'h00; // slli x23, x16, 5
mem[188]=8'h13; mem[189]=8'h5c; mem[190]=8'h49; mem[191]=8'h00; // srli x24, x18, 4
mem[192]=8'h93; mem[193]=8'h5c; mem[194]=8'h4a; mem[195]=8'h40; // srai x25, x20, 4
mem[196]=8'h83; mem[197]=8'h02; mem[198]=8'hc0; mem[199]=8'h12; // lb   x5,  300(x0)
mem[200]=8'h03; mem[201]=8'h13; mem[202]=8'he0; mem[203]=8'h12; // lh   x6,  302(x0)
mem[204]=8'h03; mem[205]=8'h4e; mem[206]=8'h10; mem[207]=8'h13; // lbu  x28, 305(x0)
mem[208]=8'h83; mem[209]=8'h5e; mem[210]=8'h60; mem[211]=8'h13; // lhu  x29, 310(x0)
mem[212]=8'he7; mem[213]=8'h0a; mem[214]=8'h10; mem[215]=8'h00; // jalr x21, 1(x0))

//            // --- init the source registers we will store ---
//              mem[0] =8'h93; mem[1] =8'h0a; mem[2] =8'h00; mem[3] =8'h08; // addi x21, x0, 128        (0x08000A93)
//              mem[4] =8'h13; mem[5] =8'h0b; mem[6] =8'h00; mem[7] =8'hf0; // addi x22, x0, -256       (0xF0000B13)
//              mem[8] =8'h93; mem[9] =8'h0f; mem[10]=8'h50; mem[11]=8'h00; // addi x31, x0, 5          (0x00500F93)
            
//              // --- stores at 320, 324, 328 (user-provided encodings) ---
//              mem[12]=8'h23; mem[13]=8'h00; mem[14]=8'h50; mem[15]=8'h15; // sb   x21, 320(x0)        (0x15500023)
//              mem[16]=8'h23; mem[17]=8'h12; mem[18]=8'h60; mem[19]=8'h15; // sh   x22, 324(x0)        (0x15601223)
//              mem[20]=8'h23; mem[21]=8'h24; mem[22]=8'hf0; mem[23]=8'h15; // sw   x31, 328(x0)        (0x15F02423)
            
//              // --- loads back from the SAME addresses to verify ---
//              mem[24]=8'h03; mem[25]=8'h05; mem[26]=8'h00; mem[27]=8'h14; // lb   x10, 320(x0)        (0x14000503)
//              mem[28]=8'h03; mem[29]=8'h16; mem[30]=8'h40; mem[31]=8'h14; // lh   x12, 324(x0)        (0x14401603)
//              mem[32]=8'h03; mem[33]=8'h27; mem[34]=8'h80; mem[35]=8'h14; // lw   x14, 328(x0)        (0x14802703)
        end

endmodule