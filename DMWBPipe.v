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
    input [31:0]inst_DM,
    output reg [31:0]inst_WB,
    input stall_DMWB,
    input is_Ld_DM,
    output reg is_Ld_WB,
    input [31:0] aluResult_DM,
    output reg [31:0] aluResult_WB = 0,
    input [31:0] DMResult_DM,
    output reg [31:0] DMResult_WB = 0,
    //Forwarding
    input [4 : 0] rd_DM,
    output reg [4:0] rd_WB = 0,
    input isWb_DM,
    output reg isWb_WB = 0
    );
    
    always@(posedge clk)begin
        if(~stall_DMWB) begin
                inst_WB <= inst_DM;
                is_Ld_WB <= is_Ld_DM;
                aluResult_WB <= aluResult_DM;
                DMResult_WB <= DMResult_DM;
                //Forwarding
                rd_WB <= rd_DM;
                isWb_WB <= isWb_DM;
            end
    end
endmodule
