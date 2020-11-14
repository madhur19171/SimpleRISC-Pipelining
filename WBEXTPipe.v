`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2020 11:05:34
// Design Name: 
// Module Name: WBEXTPipe
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


module WBEXTPipe(
    input clk,
    input stall_WBEXT,
    input [4:0] rd_WB,
    output  reg[4:0] rd_EXT,
    input [31:0] WriteData_WB,
    output reg[31:0] WriteData_EXT
    );
    
    always@(posedge clk)begin
        if(~stall_WBEXT)begin
            rd_EXT <= rd_WB;
            WriteData_EXT <= WriteData_WB;
        end
    end
endmodule
