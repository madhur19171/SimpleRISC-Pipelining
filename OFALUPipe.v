`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2020 23:28:20
// Design Name: 
// Module Name: OFALUPipe
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module OFALUPipe(
    input clk,
    input isImmediate_OF,
    output reg isImmediate_ALU,
    input [31:0] immx_OF,
    output reg [31:0] immx_ALU = 0,
    input [31:0]inst_OF,
    output reg [31:0]inst_ALU,
    input stall_OFALU,
    input is_Ld_OF,
    output reg is_Ld_ALU,
    input is_St_OF,
    output reg is_St_ALU,
    input [31:0] A_OF,
    output reg [31:0] A_ALU = 0,
    input [31:0] B_OF,
    output reg [31:0] B_ALU = 0,
    input [31:0] op1_OF,
    output reg [31:0] op1_ALU = 0,
    input [31:0] op2_OF,
    output reg [31:0] op2_ALU = 0,
    input [12:0] aluSignals_OF,
    output reg [12:0] aluSignals_ALU = 0,
    //Reverting
    input [4 : 0] rd_OF,
    output reg [4:0] rd_ALU = 0,
    input isWb_OF,
    output reg isWb_ALU= 0,
    //Forwarding
    input [4 : 0] RP1_OF,
    output reg [4 : 0] RP1_ALU = 0,
    input [4 : 0] RP2_OF,
    output reg [4 : 0] RP2_ALU = 0
    );
    
    always @(posedge clk)begin
        if(~stall_OFALU)begin
            isImmediate_ALU <= isImmediate_OF;
            immx_ALU <= immx_OF;
            inst_ALU <= inst_OF;
            is_Ld_ALU <= is_Ld_OF;
            is_St_ALU <= is_St_OF;
            A_ALU <= A_OF;
            B_ALU <= B_OF;
            op1_ALU <= op1_OF;
            op2_ALU <= op2_OF;
            aluSignals_ALU <= aluSignals_OF;
            rd_ALU <= rd_OF;
            isWb_ALU <= isWb_OF; 
            RP1_ALU <= RP1_OF;
            RP2_ALU <= RP2_OF;
            end
    end
    
endmodule
