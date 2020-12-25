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
   output reg [31:0] 	    pc = 0;
   input stop;
   
   //To be dent to Instruction Memory:
   input [31 : 0] IMdouta;
   output [6 : 0] IMaddra;
   output IMclka;
   
   reg stopped = 0;
   
   //Instruction Memory Ports Assignmnets
   assign IMclka = clk;     //IM is triggered to read instruction only on 
                            //positive edge of RIM(Read Instruction Memory)
   assign IMaddra = pc[6 : 0];  //PC is given as address to IM.
   
   
   assign inst = IMdouta;       //Data received from IM is the Instruction and assigned to inst
   
   
   always @(posedge clk, posedge rst) begin//add posedge stop for better functionality
      if(rst)
         pc <= 0;
      else if(isBranchTaken)
         pc <= branchPC;
      else if(stop) begin  //Stops PC increment on Read Instruction
            if(~stopped) begin
                    pc <= pc - 1;  //This way IM will read the previous instruction now
                    stopped <= 1;   //The importance of this can be understood by commenting out this if else block
                end
            else pc <= pc;
         end
      else begin
            pc <= pc + 1;
            stopped = 0;
         end
   end
endmodule