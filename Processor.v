`timescale 1ns/1ns
module Processor(input clk, input rst,
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
    
   //wire rst;
   
   wire [31:0] immx, branchTarget, branchPC, aluResult,
	       data, WriteData;
   wire [4:0] WP;
   wire [22:1] signal;
   wire [5:0] opcodeI;
   wire       isBranchTaken, flagsE, flagsGT;
   wire DoClk, pulse, clock;
   wire stop;
   
   //Reverting:
   //:rd
   //:isWb
	     
   //Data Memory Interfacing Declarations
	      

   wire[31:0] inst_IF, inst_OF, pc_IF, pc_OF;
   
   wire [31 : 0] op1_OF, op1_ALU, op2_OF, op2_ALU;
   wire [12 : 0] aluSignals_OF, aluSignals_ALU;
   wire [4 : 0] rd_OF, rd_ALU;
   wire isWb_OF, isWb_ALU;
   
   wire[31:0] aluResult_ALU, aluResult_DM, op2_DM;
   wire[4:0] rd_DM;
   wire isWb_DM;
   
   wire[31:0] aluResult_WB, DMResult_DM, DMResult_WB;
   wire [4:0] rd_WB;
   wire isWb_WB;
   
   wire [31 : 0] A_ALU, B_ALU;
   wire [4 : 0] rs1_OF, rs2_OF, rs1_ALU, rs2_ALU;
   
   
   
//    vio_1 vio (
//  .clk(clk),                // input wire clk
//  .probe_in0(pc_IF),    // input wire [31 : 0] probe_in0
//  .probe_in1(inst_OF),    // input wire [31 : 0] probe_in1
//  .probe_in2(op1_OF),    // input wire [31 : 0] probe_in2
//  .probe_in3(op2_OF),    // input wire [31 : 0] probe_in3
//  .probe_in4(WriteData),    // input wire [31 : 0] probe_in4
//  .probe_out0(rst)  // output wire [0 : 0] probe_out0
//);  
   
   IFUnit IF(.inst(inst_IF),.pc(pc_IF), .stop(stop),
	     .clk(clock),.isBranchTaken(0),.branchPC(0),.rst(rst),
	     //Instruction Memory Interface
	     .IMclka(IMclka), .IMaddra(IMaddra),
	     .IMdouta(IMdouta)
	     );
	     
	     IFOFPipe ifofpipe(
	           .clk(clock),//
	           .stop(stop),
	           .inst_IF(inst_IF),//
	           .inst_OF(inst_OF),//
	           .pc_IF(pc_IF),//
	           .pc_OF(pc_OF)//
	     );
	     
   OFUnit OF(.immx(immx),.branchTarget(branchTarget),.op1(op1_OF),.op2(op2_OF),.opcodeI(opcodeI), .rd(rd_OF), .rs1(rs1_OF), .rs2(rs2_OF),
	     .clk(clock) , .pc(pc_OF),.inst(inst_OF), .isImmediate(signal[6]), .isSt(signal[1]),.isRet(signal[5]),.isWb(isWb_WB),
	     .WriteData(WriteData),.WP(WP));
	     
	     
   assign aluSignals_OF = signal[22 : 10];
   assign isWb_OF = signal[7];
   
        OFALUPipe ofalupipe(
                .clk(clock),//
                .op1_OF(op1_OF),//
                .op1_ALU(op1_ALU),//
                .op2_OF(op2_OF),//
                .op2_ALU(op2_ALU),//
                .aluSignals_OF(aluSignals_OF),//
                .aluSignals_ALU(aluSignals_ALU),//
                .rd_OF(rd_OF),//
                .rd_ALU(rd_ALU),//
                .isWb_OF(isWb_OF),//
                .isWb_ALU(isWb_ALU),//
                .rs1_OF(rs1_OF),
                .rs2_OF(rs2_OF),
                .rs1_ALU(rs1_ALU),
                .rs2_ALU(rs2_ALU)
        );
        
   BranchUnit BU(.branchPC(branchPC), .isBranchTaken(isBranchTaken),
		 .branchTarget(branchTarget), .op1(0), 
		 .isRet(signal[5]), .isUBranch(signal[8]), .isBeq(signal[3]), .flagsE(flagsE), .isBgt(signal[4]),
		  .flagsGT(flagsGT));
   
   ALUUnit ALU(.aluResult(aluResult_ALU), .flagsE(flagsE), .flagsGT(flagsGT),
	        .op1(A_ALU), .op2(B_ALU),  .aluSignals(aluSignals_ALU));
   
   ALUDMPipe aludmpipe(
        .clk(clock),//
        .aluResult_ALU(aluResult_ALU),//
        .aluResult_DM(aluResult_DM),//
        .op2_ALU(op2_ALU),//
        .op2_DM(op2_DM),//
        .rd_ALU(rd_ALU),//
        .rd_DM(rd_DM),//
        .isWb_ALU(isWb_ALU),//
        .isWb_DM(isWb_DM)//
    );
   
   MAUnit DM(.data(DMResult_DM), 
		 .clk(clock), .RWA(aluResult_DM), .WD(op2_DM), .isLd(signal[2]), .isSt(signal[1]),
		 //Data Memory Interface
	     .clka(DMclka), .ena(DMena), .wea(DMwea), .addra(DMaddra), .dina(DMdina),
	     .douta(DMdouta)
		 );
		 
		 
   DMWBPipe dmwbpipe(
        .clk(clock),//
        .aluResult_DM(aluResult_DM),//
        .aluResult_WB(aluResult_WB),//
        .DMResult_DM(DMResult_DM),//
        .DMResult_WB(DMResult_WB),//
        .rd_DM(rd_DM),//
        .rd_WB(rd_WB),//
        .isWb_DM(isWb_DM),//
        .isWb_WB(isWb_WB)//
   );
   
   
   WBUnit WB(.WriteData(WriteData), .WP(WP),
	     .isCall(signal[9]), .isLd(signal[2]), .pc(0), .ldResult(DMResult_WB), .aluResult(aluResult_WB), .rd(rd_WB)
	     );
   
   ControlUnit CU(.signal(signal)
		  ,.opcodeI(opcodeI));
   
   
   ForwardingUnit forwarding(.A(A_ALU), .B(B_ALU),
                             .rd_DM(rd_DM), .rd_WB(rd_WB),
                             .rs1_ALU(rs1_ALU), .rs2_ALU(rs2_ALU),
                             .op1_ALU(op1_ALU), .op2_ALU(op2_ALU),
                             .result_DM(aluResult_DM), .result_WB(WriteData)
   );
  //FrequencyDivider FD1(.clk(clk), .clock(clock));
  assign clock = clk;
   
endmodule // DFF


