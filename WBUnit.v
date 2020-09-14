`timescale 1s/1ms
module WBUnit(WriteData, WP, 
	      isCall, isLd, pc, ldResult, aluResult, rd);
   input isCall, isLd;
   input[31:0] ldResult, aluResult;
   input [31:0] pc;
   input [4:0] rd;
   output reg [31:0] WriteData;
   output [4:0]WP;
   always @(isLd, isCall, aluResult, ldResult, pc)
     begin
	case({isCall, isLd})
	  2'b00: WriteData <= aluResult;
	  2'b01: WriteData <= ldResult;
	  2'b10: WriteData <= pc + 1;
    default : WriteData <= 0;
	endcase // case ({isCall, isLd})
     end
   assign WP = (isCall) ? 31 : rd;
endmodule // DFF


