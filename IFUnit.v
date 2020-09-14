`timescale 1s/1ms
module IFUnit(inst,pc, stop,
	      RIM, UPC, isBranchTaken,branchPC,rst,
	      //Instruction Memory Interface:
	      IMclka, IMaddra,
	      IMdouta
	      );
	      
   //Module Specific
   input RIM, isBranchTaken, rst, UPC;
   input [31:0] branchPC;
   output [31:0] inst;
   output reg [31:0] 	    pc;
   output stop;
   
   //To be dent to Instruction Memory:
   input [31 : 0] IMdouta;
   output [6 : 0] IMaddra;
   output IMclka;
   
   //Instruction Memory Ports Assignmnets
   assign IMclka = RIM;     //IM is triggered to read instruction only on 
                            //positive edge of RIM(Read Instruction Memory)
   assign IMaddra = pc[6 : 0];  //PC is given as address to IM.
   assign inst = IMdouta;       //Data received from IM is the Instruction and assigned to inst
   
   
   assign stop = inst[31:27] == 5'b11111; 
   
   always @(posedge UPC, posedge rst) begin
      if(rst)
         pc <= 0;
      else if(isBranchTaken)
         pc <= branchPC;
      else
         pc <= pc + 1;
   end
endmodule