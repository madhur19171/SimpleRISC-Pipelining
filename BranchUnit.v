`timescale 1s/1ms
module BranchUnit(branchPC, isBranchTaken,
		  pc_ALU, immx_ALU, A_ALU, isRet_ALU, isUBranch_ALU, isBeq_ALU, flagsE, isBgt_ALU, flagsGT);
   input [31:0] pc_ALU, immx_ALU, A_ALU;
   input 	isUBranch_ALU, isBeq_ALU, isBgt_ALU, isRet_ALU, flagsGT, flagsE;
   output [31:0] branchPC;
   output 	 isBranchTaken;
   assign branchPC = isRet_ALU ? A_ALU : pc_ALU + immx_ALU;
   assign isBranchTaken = isUBranch_ALU | (isBeq_ALU & flagsE) | (isBgt_ALU & flagsGT);
endmodule // DFF


