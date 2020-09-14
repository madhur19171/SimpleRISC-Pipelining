`timescale 1ns/1ns
module Processor(input clk,// input rst,
        //Data Memory Interfacing components:
   output DMclka, DMena, DMwea,
   output [6 : 0] DMaddra,
   output [31 : 0] DMdina,
   input [31 : 0] DMdouta,
        //Instruction Memory Interfacing components:
   output IMclka,
   output [6 : 0] IMaddra,
   input [31 : 0] IMdouta
    );
    
   wire rst;
   
   wire [31:0] inst, pc, immx, branchTarget, op1, op2, branchPC, aluResult,
	       data, WriteData;
   wire [4:0] WP;
   wire [22:1] signal;
   wire [5:0] opcodeI;
   wire       isBranchTaken, flagsE, flagsGT;
   wire DoClk, pulse, clock;
   wire updatePC, ReadIM, ReadRF, DMop, WriteRF, stop;
	     
   //Data Memory Interfacing Declarations
	      
  vio_1 vio (
  .clk(clk),                // input wire clk
  .probe_in0(pc),    // input wire [31 : 0] probe_in0
  .probe_in1(inst),    // input wire [31 : 0] probe_in1
  .probe_in2(op1),    // input wire [31 : 0] probe_in2
  .probe_in3(op2),    // input wire [31 : 0] probe_in3
  .probe_in4(WriteData),    // input wire [31 : 0] probe_in4
  .probe_out0(rst)  // output wire [0 : 0] probe_out0
);
	 
   SyncController synccontroller(.clk(clock), .stop(stop), .rst(rst),
                .updatePC(updatePC),  .ReadIM(ReadIM), .ReadRF(ReadRF), .DMop(DMop), .WriteRF(WriteRF));    
   IFUnit IF(.inst(inst),.pc(pc), .stop(stop),
	     .RIM(ReadIM), .UPC(updatePC),.isBranchTaken(isBranchTaken),.branchPC(branchPC),.rst(rst),
	     //Instruction Memory Interface
	     .IMclka(IMclka), .IMaddra(IMaddra),
	     .IMdouta(IMdouta)
	     );
	     
   OFUnit OF(.immx(immx),.branchTarget(branchTarget),.op1(op1),.op2(op2),.opcodeI(opcodeI), 
	     .RRF(ReadRF), .WRF(WriteRF), .DMop(DMop), .UPC(updatePC) ,
	     .pc(pc),.inst(inst),.isSt(signal[1]),.isRet(signal[5]),.isWb(signal[7]),
	     .WriteData(WriteData),.WP(WP));
   
   BranchUnit BU(.branchPC(branchPC), .isBranchTaken(isBranchTaken),
		 .branchTarget(branchTarget), .op1(op1), 
		 .isRet(signal[5]), .isUBranch(signal[8]), .isBeq(signal[3]), .flagsE(flagsE), .isBgt(signal[4]),
		  .flagsGT(flagsGT));
   
   ALUUnit ALU(.aluResult(aluResult), .flagsE(flagsE), .flagsGT(flagsGT),
	        .op1(op1), .op2(op2), .immx(immx), .isImmediate(signal[6]), .aluSignals(signal[22:10]));
   
   MAUnit DM(.data(data), 
		 .DMop(DMop), .RWA(aluResult), .WD(op2), .isLd(signal[2]), .isSt(signal[1]),
		 //Data Memory Interface
	     .clka(DMclka), .ena(DMena), .wea(DMwea), .addra(DMaddra), .dina(DMdina),
	     .douta(DMdouta)
		 );
   
   WBUnit WB(.WriteData(WriteData), .WP(WP),
	     .isCall(signal[9]), .isLd(signal[2]), .pc(pc), .ldResult(data), .aluResult(aluResult), .rd(inst[25:21])
	     );
   
   ControlUnit CU(.signal(signal)
		  ,.opcodeI(opcodeI));
   
  FrequencyDivider FD1(.clk(clk), .clock(clock));
  //assign clock = clk;
   
endmodule // DFF


