`timescale 1s/1ms
module IFUnit(inst,pc,
          clk,  stop, stall_IFOF,
	      isBranchTaken,branchPC,rst,
	      //Instruction Memory Interface:
	      IMclka, IMaddra, IMena,
	      IMdouta
	      );
	      
   //Module Specific
   input  clk, isBranchTaken, rst;
   input [31:0] branchPC;
   output [31:0] inst;
   output reg [31:0] 	    pc = 0;
   input stop, stall_IFOF;
   
   //To be dent to Instruction Memory:
   input [31 : 0] IMdouta;
   output [6 : 0] IMaddra;
   output IMclka;
   output IMena;
   
   reg stopped = 0;
   reg [31:0] nextPC;
   
   //Instruction Memory Ports Assignmnets
   assign IMclka = clk;     //IM is triggered to read instruction only on 
                            //positive edge of RIM(Read Instruction Memory)
   assign IMaddra = pc[6 : 0];  //PC is given as address to IM.
   
   
   assign inst = IMdouta;       //Data received from IM is the Instruction and assigned to inst

    always@(posedge clk)
        pc <= nextPC;
   
   
   always@(*)begin
        if(rst)
            nextPC = 0;
        else if(isBranchTaken)
            nextPC = branchPC;
        else if(stop || stall_IFOF)//Stall the PC increment on load or division stall
            nextPC = pc;
        else
            nextPC = pc + 1;
   end
   
   //The IM will not produce new instruction if the pipeline is stalled due to division or load
    assign IMena = ~(stall_IFOF || stop);
    
endmodule