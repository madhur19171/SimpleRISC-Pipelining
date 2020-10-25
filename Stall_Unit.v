`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2020 20:01:21
// Design Name: 
// Module Name: Stall_Unit
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


module Stall_Unit(
    input DMdone,
    input is_Ld,
    input is_St,
    input stop,
    output reg stall_IFOF,
    output reg stall_OFALU,
    output reg stall_ALUDM,
    output reg stall_DMWB
    );
    
    always @(*) begin
        if(stop) begin
            stall_IFOF = 1;
            stall_OFALU = 1;
            stall_ALUDM = 1;
            stall_DMWB = 1;
        end 
        else
            if(is_Ld ) begin
                if(~DMdone) begin
                    stall_IFOF = 1;
                    stall_OFALU = 1;
                    stall_ALUDM = 1;
                    stall_DMWB = 1;
                end
                else begin
                    stall_IFOF = 0;
                    stall_OFALU = 0;
                    stall_ALUDM = 0;
                    stall_DMWB = 0;
                end
                    
            end
            else begin
                stall_IFOF = 0;
                stall_OFALU = 0;
                stall_ALUDM = 0;
                stall_DMWB = 0;
            end
    end
    
endmodule
