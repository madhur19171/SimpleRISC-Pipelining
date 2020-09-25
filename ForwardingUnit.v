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
input [4 : 0] rs1_ALU, rs2_ALU,
input [31 : 0] op1_ALU, op2_ALU,
input [31 : 0] result_DM,
input [31 : 0] result_WB
    );
    
    always@(*)begin
        if(rs1_ALU == rd_DM && rd_DM != 0)
            A = result_DM;
        else if(rs1_ALU == rd_WB && rd_WB != 0)
            A = result_WB;
        else
            A = op1_ALU;
            
        if(rs2_ALU == rd_DM  && rd_DM != 0)
            B = result_DM;
        else if(rs2_ALU == rd_WB && rd_WB != 0)
            B = result_WB;
        else
            B = op2_ALU;
    end
endmodule
