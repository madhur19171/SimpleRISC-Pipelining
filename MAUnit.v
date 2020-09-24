`timescale 1s/1ms
module MAUnit(
            //For Module
          data, 
		  clk, RWA, WD, isLd, isSt,
		  //For Data Memory Interface
		  clka, ena, wea, addra, dina,
		  douta
		  );
   //Module Specific
   input[31:0]  WD;
   input [31 : 0] RWA;
   input 	isLd, isSt, clk;
   output wire  [31:0] data;
   
   //To be sent to Data Memory
   output clka, ena, wea;
   output [6 : 0] addra;
   output [31 : 0] dina;
   input [31 : 0] douta;
   
   // Data Memory Ports Assignments
   assign clka = clk;      //Data Memory Reads or Writes on positive edge of DMop. Controlled by SyncController.
   assign ena = isLd | isSt;    //Dama Memory is to be used when the Instruction is Load or Store.
   assign wea = isSt;   //Writes to Data Memory only on Store instruction
   assign addra = RWA;  //Address to be accessed is RWA(Read/Write Address) 
   assign dina = WD;    //WD (Write Data) is the data that needs to be written into the memory in case of Store.
   assign data = douta; //Output of Memory Access Unit is the data of Data Memory when Read.

endmodule //

