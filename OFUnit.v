`timescale 1s/1ms
module OFUnit(immx,branchTarget,op1,op2,opcodeI, rd,
	      clk, pc,inst,isSt,isRet,isWb,WriteData,WP);
   input  clk, isSt, isRet, isWb;
   input [31:0] inst, WriteData, pc;
   input [4:0] 	WP;   //Write Port


   output [31:0] immx, branchTarget;
   output reg [31:0] op1, op2;
   output [5:0]  opcodeI;
   output [4:0] rd;
  

    integer i;
   wire [4:0] 	 RP1, RP2;
   wire [31:0] 	 signExtend;
   
   reg [31:0] RegisterFile[31:0];

   initial begin
        for(i = 0; i <= 31; i = i + 1)begin
            RegisterFile[i] = 0;
        end
   end
// RegisterFile registerfile (
//  .clka(clk),    // input wire clka
//  .ena(1'b1),      // input wire ena
//  .wea(1'b0),      // input wire [0 : 0] wea
//  .addra(RP1),  // input wire [3 : 0] addra
//  .dina(32'd0),    // input wire [31 : 0] dina
//  .douta(op1),  // output wire [31 : 0] douta
  
  
//  .clkb(clk),    // input wire clkb
//  .enb(1'b1),      // input wire enb
//  .web(isWb),      // input wire [0 : 0] web
//  .addrb(RP2),  // input wire [3 : 0] addrb
//  .dinb(WriteData),    // input wire [31 : 0] dinb
//  .doutb(op2)  // output wire [31 : 0] doutb
//);


    assign RP1 = (isRet)?  31 : inst[20:16];
    assign RP2 = (isSt) ? inst[25:21] : inst[15:11];
    assign rd = inst[25:21];
    //assign RP2 = (isSt) ? inst[25:22] : inst[17:14]; 
        
    always @(*)begin
        op1 <= RegisterFile[RP1];
        op2 <= RegisterFile[RP2];
    end
    
    always @(posedge clk)
        if(isWb)
            RegisterFile[WP] <= WriteData;
        
   assign signExtend = {{5{inst[26]}}, inst[26:0]};
   assign branchTarget = pc + signExtend;
   assign immx = {{16{inst[15]}}, inst[15:0]};
   assign opcodeI = {inst[31:27], inst[26]};
   
endmodule // DFF

