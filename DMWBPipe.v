`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2020 16:41:09
// Design Name: 
// Module Name: DMWBPipe
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


module DMWBPipe(
    input clk,
    input [31:0] aluResult_DM,
    output reg [31:0] aluResult_WB,
    input [31:0] DMResult_DM,
    output reg [31:0] DMResult_WB,
    //Forwarding
    input [4 : 0] rd_DM,
    output reg [4:0] rd_WB,
    input isWb_DM,
    output reg isWb_WB
    );
    
    always@(posedge clk)begin
        aluResult_WB <= aluResult_DM;
        DMResult_WB <= DMResult_DM;
        //Forwarding
        rd_WB <= rd_DM;
        isWb_WB <= isWb_DM;
    end
endmodule
