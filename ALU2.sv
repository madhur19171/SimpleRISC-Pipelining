`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2020 11:20:10
// Design Name: 
// Module Name: ALU2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUUnit_2(aluResult, flagsE, flagsGT, div_stall,
	       clk, isImmediate, immx, A_ALU, B_ALU, aluSignals);
   input[31:0] immx, A_ALU, B_ALU;
   input isImmediate, clk;
   input [12:0] aluSignals;
   output div_stall;
   output wire [31:0] aluResult;
   output reg	 flagsE = 0, flagsGT = 0;
   wire [31:0] 	 A, B;
   wire [31:0] 	 ADD, MUL, DIV, SHI, LOG, MOV;
   assign A = A_ALU;
   assign B = isImmediate ? immx : B_ALU;
   
   always @(*)
        if(aluSignals[2]) begin
            flagsE = A == B;
            flagsGT = A > B;
        end
   
   assign ADD = aluSignals[0] ? A + B : A - B;

   assign SHI = aluSignals[6] ? A << B : aluSignals[7] ? A >> B : A >>> B;
   
   
   assign MUL = A * B;

   assign LOG = aluSignals[9] ? A | B : aluSignals[11] ? ~A : A & B;
   
   //assign DIV = aluSignals[4] ? A / B : A % B;
   
   wire [31:0] Quo, Rem;
   //assign div_stall = 0;
   ALUDivision DIVISION (.clk(clk), .isDiv(aluSignals[4] | aluSignals[5]),
                            .A(A), .B(B),  .stall(div_stall), .Quo(Quo), .Rem(Rem));
                            
   assign DIV = aluSignals[4] ? Quo : Rem; 
   
   assign MOV = B;

   bufif1 b1[31:0](aluResult, ADD, aluSignals[0] | aluSignals[1]);
   bufif1 b2[31:0](aluResult, SHI, aluSignals[6] | aluSignals[7] | aluSignals[8]);
   bufif1 b3[31:0](aluResult, MUL, aluSignals[3]);
   bufif1 b4[31:0](aluResult, LOG, aluSignals[9] | aluSignals[10] | aluSignals[11]);
   bufif1 b5[31:0](aluResult, DIV, aluSignals[4] | aluSignals[5]);
   bufif1 b6[31:0](aluResult, MOV, aluSignals[12]);

endmodule // DFF