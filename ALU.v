`timescale 1s/1ms
module ALUUnit(aluResult, flagsE, flagsGT,
	       A_ALU, B_ALU, aluSignals);
   input[31:0] A_ALU, B_ALU;
   input [12:0] aluSignals;
   output wire [31:0] aluResult;
   output reg	 flagsE, flagsGT;
   wire [31:0] 	 A, B;
   wire [31:0] 	 ADD, MUL, DIV, SHI, LOG, MOV;
   assign A = A_ALU;
   assign B = B_ALU;
   
   always @(*)
        if(aluSignals[2]) begin
            flagsE = A == B;
            flagsGT = A > B;
        end
   
   assign ADD = aluSignals[0] ? A + B : A - B;
   assign SHI = aluSignals[6] ? A << B : aluSignals[7] ? A >> B : A >>> B;
   assign MUL = A * B;
   assign LOG = aluSignals[9] ? A | B : aluSignals[11] ? ~A : A & B;
   assign DIV = aluSignals[4] ? A / B : A % B;
   assign MOV = B;

   bufif1 b1[31:0](aluResult, ADD, aluSignals[0] | aluSignals[1]);
   bufif1 b2[31:0](aluResult, SHI, aluSignals[6] | aluSignals[7] | aluSignals[8]);
   bufif1 b3[31:0](aluResult, MUL, aluSignals[3]);
   bufif1 b4[31:0](aluResult, LOG, aluSignals[9] | aluSignals[10] | aluSignals[11]);
   bufif1 b5[31:0](aluResult, DIV, aluSignals[4] | aluSignals[5]);
   bufif1 b6[31:0](aluResult, MOV, aluSignals[12]);

endmodule // DFF


