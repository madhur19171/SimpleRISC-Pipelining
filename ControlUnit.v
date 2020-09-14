`timescale 1s/1ms
module ControlUnit(signal,
		   opcodeI);
   input [5:0]opcodeI;
   output [22:1] signal;
   wire 	 op1, op2, op3, op4, op5, I;
   assign op1 = opcodeI[1];
   assign op2 = opcodeI[2];
   assign op3 = opcodeI[3];
   assign op4 = opcodeI[4];
   assign op5 = opcodeI[5];
   assign I = opcodeI[0];
   assign signal[1] = op1&op2&op3&op4&~op5;
   assign signal[2] = ~op1&op2&op3&op4&~op5;
   assign signal[3] = ~op1&~op2&~op3&~op4&op5;
   assign signal[4] = op1&~op2&~op3&~op4&op5;
   assign signal[5] = ~op1&~op2&op3&~op4&op5;
   assign signal[6] = I;
   assign signal[7] = ~(op5 | ~op5&op3&op1&(op4 | ~op2)) | op1&op2&~op3&~op4&op5;
   assign signal[8] = op5&~op4&(~op3&op2 | op3&~op2&~op1);
   assign signal[9] = op1&op2&~op3&~op4&op5;
   assign signal[10] = ~op1&~op2&~op3&~op4&~op5 | op2&op3&op4&~op5;
   assign signal[11] = op1&~op2&~op3&~op4&~op5;
   assign signal[12] = op1&~op2&op3&~op4&~op5;
   assign signal[13] = ~op1&op2&~op3&~op4&~op5;
   assign signal[14] = op1&op2&~op3&~op4&~op5;
   assign signal[15] = ~op1&~op2&op3&~op4&~op5;
   assign signal[16] = ~op1&op2&~op3&op4&~op5;
   assign signal[17] = op1&op2&~op3&op4&~op5;
   assign signal[18] = ~op1&~op2&op3&op4&~op5;
   assign signal[19] = op1&op2&op3&~op4&~op5;
   assign signal[20] = ~op1&op2&op3&~op4&~op5;
   assign signal[21] = ~op1&~op2&~op3&op4&~op5;
   assign signal[22] = op1&~op2&~op3&op4&~op5;
endmodule // DFF


