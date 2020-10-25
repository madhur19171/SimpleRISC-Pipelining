`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2020 23:13:56
// Design Name: 
// Module Name: IFOFPipe
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


module IFOFPipe(
    input clk,
    input stall_IFOF,
    input [31:0] inst_IF,
    output reg [31:0] inst_OF = 0,
    input [31:0] pc_IF,
    output reg [31:0] pc_OF = 0
    );

    always @(posedge clk) begin
        if(~stall_IFOF) begin
            inst_OF <= inst_IF;
            pc_OF <= pc_IF;
            end
    end
endmodule