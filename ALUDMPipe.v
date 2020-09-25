`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2020 16:25:15
// Design Name: 
// Module Name: ALUDMPipe
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


module ALUDMPipe(
    input clk,
    input [31:0] aluResult_ALU,
    output reg [31:0] aluResult_DM = 0,
    input [31:0] op2_ALU,
    output reg [31:0] op2_DM = 0,
    //Forwarding
    input [4 : 0] rd_ALU,
    output reg [4:0] rd_DM = 0,
    input isWb_ALU,
    output reg isWb_DM = 0
    );
    
    always @(posedge clk)begin
        aluResult_DM <= aluResult_ALU;
        op2_DM <= op2_ALU;
        rd_DM <= rd_ALU;
        isWb_DM <= isWb_ALU;
    end
endmodule
