`timescale 1s/1ms
module IFUnit(inst,pc,
          clk,  stop,
	      isBranchTaken,branchPC,rst,
	      //Instruction Memory Interface:
	      IMclka, IMaddra,
	      IMdouta
	      );
	      
   //Module Specific
   input  clk, isBranchTaken, rst;
   input [31:0] branchPC;
   output [31:0] inst;
   output reg [31:0] 	    pc;
   input stop;
   
   //To be dent to Instruction Memory:
   input [31 : 0] IMdouta;
   output [6 : 0] IMaddra;
   output IMclka;
   
   
   //Instruction Memory Ports Assignmnets
   assign IMclka = clk;     //IM is triggered to read instruction only on 
                            //positive edge of RIM(Read Instruction Memory)
   assign IMaddra = pc[6 : 0];  //PC is given as address to IM.
   
   
   assign inst = IMdouta;       //Data received from IM is the Instruction and assigned to inst
   
   
   always @(posedge clk, posedge rst) begin
      if(rst)
         pc <= 0;
      else if(isBranchTaken)
         pc <= branchPC;
      else if(stop)  //Stops PC increment on Read Instruction
         pc <= pc;
      else
         pc <= pc + 1;
   end
endmodule