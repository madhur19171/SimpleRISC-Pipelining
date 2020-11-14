`timescale 1ns/1ns
module Processor(input clk, input rst,
        //Data Memory Interfacing components:
   output DMclka, DMena, DMwea,
   output [6 : 0] DMaddra,
   output [31 : 0] DMdina,
   input [31 : 0] DMdouta,
   input DMdone,
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
	      

   wire[31:0] inst_IF, inst_OF, inst_ALU, inst_DM, inst_WB, pc_IF, pc_OF, pc_ALU;
   
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
   
   wire [4:0] rd_EXT;
   wire [31:0] WriteData_EXT;
   
   wire [31 : 0] B_DM, A_ALU, B_ALU, A_OF, B_OF, A_FWD, B_FWD;
   wire [4 : 0] RP1_OF, RP2_OF, RP1_ALU, RP2_ALU;
   
   
   wire stall_IFOF, stall_OFALU, stall_ALUDM, stall_DMWB, stall_WBEXT;
   wire is_Ld_OF, is_St_OF, is_Ld_ALU, is_St_ALU, is_Ld_DM, is_St_DM, is_Ld_WB;
   
   wire[31:0] immx_ALU;
   wire isImmediate_ALU;
   
   wire isBeq_OF, isBeq_ALU, isBgt_OF, isBgt_ALU, isUBranch_OF, isUBranch_ALU;
   
   wire flush;
   
   
   
//    vio_1 vio (
//  .clk(clk),                // input wire clk
//  .probe_in0(pc_IF),    // input wire [31 : 0] probe_in0
//  .probe_in1(inst_OF),    // input wire [31 : 0] probe_in1
//  .probe_in2(op1_OF),    // input wire [31 : 0] probe_in2
//  .probe_in3(op2_OF),    // input wire [31 : 0] probe_in3
//  .probe_in4(WriteData),    // input wire [31 : 0] probe_in4
//  .probe_out0(rst)  // output wire [0 : 0] probe_out0
//);  
   
   assign aluSignals_OF = signal[22 : 10];
   assign isWb_OF = signal[7];
   assign is_Ld_OF = signal[2];
   assign is_St_OF = signal[1];
   
   IFUnit IF(.inst(inst_IF),.pc(pc_IF), .stop(stop),
	     .clk(clock),.isBranchTaken(isBranchTaken),.branchPC(branchPC),.rst(rst),
	     //Instruction Memory Interface
	     .IMclka(IMclka), .IMaddra(IMaddra),
	     .IMdouta(IMdouta)
	     );
	     
	     IFOFPipe ifofpipe(
	           .clk(clock),//
	           .stall_IFOF(stall_IFOF),
	           .inst_IF(inst_IF),//
	           .inst_OF(inst_OF),//
	           .pc_IF(pc_IF),//
	           .pc_OF(pc_OF)//
	     );
	     
   OFUnit OF(.stop(stop), .flush(flush), .immx(immx),.branchTarget(branchTarget),.op1(op1_OF),.op2(op2_OF), .A(A_OF), .B(B_OF),
             .opcodeI(opcodeI), .rd(rd_OF), .RP1(RP1_OF), .RP2(RP2_OF),
	         .clk(clock) , .pc(pc_OF),.inst(inst_OF), .isImmediate(signal[6]),
	         .isSt(is_St_OF),.isRet(signal[5]),.isWb(isWb_WB),
	         .WriteData(WriteData),.WP(WP));
	     
	    assign isBeq_OF = signal[3];
	    assign isBgt_OF = signal[4];
	    assign isUBranch_OF = signal[8];
	    
        OFALUPipe ofalupipe(
                .clk(clock),//
                .flush(flush),
                .immx_OF(immx),
                .immx_ALU(immx_ALU),
                .isImmediate_OF(signal[6]),
                .isImmediate_ALU(isImmediate_ALU),
                .pc_OF(pc_OF),
                .pc_ALU(pc_ALU),
                .inst_OF(inst_OF),
                .inst_ALU(inst_ALU),
                .isBeq_OF(isBeq_OF),
                .isBeq_ALU(isBeq_ALU),
                .isBgt_OF(isBgt_OF),
                .isBgt_ALU(isBgt_ALU),
                .isUBranch_OF(isUBranch_OF),
                .isUBranch_ALU(isUBranch_ALU),
                .stall_OFALU(stall_OFALU),
                .is_Ld_OF(is_Ld_OF),
                .is_Ld_ALU(is_Ld_ALU),
                .is_St_OF(is_St_OF),
                .is_St_ALU(is_St_ALU),
                .A_OF(A_OF),
                .A_ALU(A_ALU),
                .B_OF(B_OF),
                .B_ALU(B_ALU),
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
                .RP1_OF(RP1_OF),
                .RP2_OF(RP2_OF),
                .RP1_ALU(RP1_ALU),
                .RP2_ALU(RP2_ALU)
        );
        
   BranchUnit BU(.branchPC(branchPC), .isBranchTaken(isBranchTaken),
                    .pc_ALU(pc_ALU), .immx_ALU(immx_ALU),
                    .isUBranch_ALU(isUBranch_ALU), .isBeq_ALU(isBeq_ALU), .flagsE(flagsE),
                    .isBgt_ALU(isBgt_ALU), .flagsGT(flagsGT));
                    
   FlushUnit flushunit(.clk(clk), .isBranchTaken(isBranchTaken), .flush(flush));
   
   ALUUnit ALU(.immx(immx_ALU), .isImmediate(isImmediate_ALU),
               .aluResult(aluResult_ALU), .flagsE(flagsE), .flagsGT(flagsGT),
	        .A_ALU(A_FWD), .B_ALU(B_FWD),  .aluSignals(aluSignals_ALU));
   
   ALUDMPipe aludmpipe(
        .clk(clock),//
        .inst_ALU(inst_ALU),
        .inst_DM(inst_DM),
        .stall_ALUDM(stall_ALUDM),
        .is_Ld_ALU(is_Ld_ALU),
        .is_Ld_DM(is_Ld_DM),
        .is_St_ALU(is_St_ALU),
        .is_St_DM(is_St_DM),
        .aluResult_ALU(aluResult_ALU),//
        .aluResult_DM(aluResult_DM),//
        .B_ALU(B_FWD),
        .B_DM(B_DM),
        .op2_ALU(op2_ALU),//
        .op2_DM(op2_DM),//
        .rd_ALU(rd_ALU),//
        .rd_DM(rd_DM),//
        .isWb_ALU(isWb_ALU),//
        .isWb_DM(isWb_DM)//
    );
   
   MAUnit DM(.data(DMResult_DM), 
		 .clk(clock), .RWA(aluResult_DM), .WD(B_DM), .isLd(is_Ld_DM), .isSt(is_St_DM),
		 //Data Memory Interface
	     .clka(DMclka), .ena(DMena), .wea(DMwea), .addra(DMaddra), .dina(DMdina),
	     .douta(DMdouta)
		 );
		 
		 
   DMWBPipe dmwbpipe(
        .clk(clock),//
        .inst_DM(inst_DM),
        .inst_WB(inst_WB),
        .stall_DMWB(stall_DMWB),
        .is_Ld_DM(is_Ld_DM),
        .is_Ld_WB(is_Ld_WB),
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
	     .isCall(signal[9]), .isLd(is_Ld_WB), .pc(0),
	     .ldResult(DMResult_WB), .aluResult(aluResult_WB), .rd(rd_WB)
	     );
   
   WBEXTPipe wbextpipe(.clk(clk), .stall_WBEXT(stall_WBEXT), .rd_WB(rd_WB), .WriteData_WB(WriteData), .rd_EXT(rd_EXT), .WriteData_EXT(WriteData_EXT));
   
   ControlUnit CU(.signal(signal)
		  ,.opcodeI(opcodeI));
   
   
   ForwardingUnit forwarding(.A(A_FWD), .B(B_FWD),
                             .rd_DM(rd_DM), .rd_WB(rd_WB), .rd_EXT(rd_EXT),
                             .RP1_ALU(RP1_ALU), .RP2_ALU(RP2_ALU),
                             .A_ALU(A_ALU), .B_ALU(B_ALU),
                             .result_DM(is_Ld_DM ? DMResult_DM : aluResult_DM), .result_WB(WriteData), .result_EXT(WriteData_EXT)
   );
   
   Stall_Unit stallunit(
        .DMdone(DMdone),
        .stop(stop),
        .is_Ld(is_Ld_DM),
        .is_St(is_St_DM),
        .stall_IFOF(stall_IFOF),
        .stall_OFALU(stall_OFALU),
        .stall_ALUDM(stall_ALUDM),
        .stall_DMWB(stall_DMWB),
        .stall_WBEXT(stall_WBEXT)
   );
   
  //FrequencyDivider FD1(.clk(clk), .clock(clock));
  assign clock = clk;
   
endmodule // DFF


