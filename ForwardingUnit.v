`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2020 12:19:01
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(
output reg  [31 : 0]A = 0,
output reg  [31 : 0]B = 0,
input [4 : 0] rd_DM,
input [4 : 0] rd_WB,
input[4:0] rd_EXT,
input [4 : 0] RP1_ALU, RP2_ALU,
input [31 : 0] A_ALU, B_ALU,
input [31 : 0] result_DM,
input [31 : 0] result_WB,
input [31:0] result_EXT
    );
    
    always@(*)begin
        if(RP1_ALU == rd_EXT && rd_EXT != 0)
            A = result_EXT;
        else if(RP1_ALU == rd_DM && rd_DM != 0)
            A = result_DM;
        else if(RP1_ALU == rd_WB && rd_WB != 0)
            A = result_WB;
        else
            A = A_ALU;
            
            
        if(RP2_ALU == rd_EXT  && rd_EXT != 0)
            B = result_EXT;   
        else if(RP2_ALU == rd_DM  && rd_DM != 0)
            B = result_DM;
        else if(RP2_ALU == rd_WB && rd_WB != 0)
            B = result_WB;
        else
            B = B_ALU;
    end
endmodule
