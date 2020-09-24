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
    input [31:0] op1_OF,
    output reg [31:0] op1_ALU,
    input [31:0] op2_OF,
    output reg [31:0] op2_ALU,
    input [12:0] aluSignals_OF,
    output reg [12:0] aluSignals_ALU,
    //Forwarding
    input [4 : 0] rd_OF,
    output reg [4:0] rd_ALU,
    input isWb_OF,
    output reg isWb_ALU
    );
    
    always @(posedge clk)begin
        op1_ALU <= op1_OF;
        op2_ALU <= op2_OF;
        aluSignals_ALU <= aluSignals_OF;
        rd_ALU <= rd_OF;
        isWb_ALU <= isWb_OF; 
    end
    
endmodule
