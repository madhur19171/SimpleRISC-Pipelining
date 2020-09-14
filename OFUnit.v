`timescale 1s/1ms
module OFUnit(immx,branchTarget,op1,op2,opcodeI,
	      RRF, WRF, DMop, UPC ,pc,inst,isSt,isRet,isWb,WriteData,WP);
   input RRF, WRF, DMop, UPC, isSt, isRet, isWb;
   input [31:0] inst, WriteData, pc;
   input [4:0] 	WP;   //Write Port


   output [31:0] immx, branchTarget;
   output wire [31:0] op1, op2;
   output [5:0]  opcodeI;
  


   wire [4:0] 	 RP1, RP2;
   wire [31:0] 	 signExtend;
   
   //reg [31:0] RegisterFile[15:0];
   
   reg WriteEnable;

   
 RegisterFile registerfile (
  .clka(RRF),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(RP1),  // input wire [3 : 0] addra
  .dina(32'd0),    // input wire [31 : 0] dina
  .douta(op1),  // output wire [31 : 0] douta
  
  
  .clkb(RRF | WRF),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .web(WriteEnable),      // input wire [0 : 0] web
  .addrb(RP2),  // input wire [3 : 0] addrb
  .dinb(WriteData),    // input wire [31 : 0] dinb
  .doutb(op2)  // output wire [31 : 0] doutb
);



   //reg, operands
//   assign RP1 = (isRet)?  15 : inst[21:18];
//   assign RP2 = (isSt) ? inst[25:22] : wen ? WP : inst[17:14];
//   always @(posedge clk)begin
//      wen <= 1'b0;
//   end
//   always @(negedge clk)
//       if(isWb) begin
//	       writedata <= data;
//	       wen <= 1'b1;
//	 end

    assign RP1 = (isRet)?  31 : inst[20:16];
    assign RP2 = (isSt) ? inst[25:21] : WriteEnable ? WP : inst[15:11];
    //assign RP2 = (isSt) ? inst[25:22] : inst[17:14]; 
           
   always @(posedge (DMop | UPC))begin
        if(DMop)
            WriteEnable <= isWb;
        if(UPC)
            WriteEnable <= 0;
     end
        
//   always @(posedge RRF)begin
//        op1 <= RegisterFile[RP1];
//        op2 <= RegisterFile[RP2];
//   end
   
//   always @(posedge WRF)
//        if(WriteEnable)
//            RegisterFile[WP] <= WriteData;
            
   //imm, operands, ControlUnit: opcodeI - Opcode, I
   assign signExtend = {{5{inst[26]}}, inst[26:0]};
   assign branchTarget = pc + signExtend;
   assign immx = {{16{inst[15]}}, inst[15:0]};
   assign opcodeI = {inst[31:27], inst[26]};
   
endmodule // DFF

