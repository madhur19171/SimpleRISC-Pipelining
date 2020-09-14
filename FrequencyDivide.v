`timescale 1s / 1ms
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2020 12:22:43
// Design Name: 
// Module Name: FrequencyDivide
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


module FrequencyDivide(
    input clk,
    input rst,
    output DoClk,
    output pulse
    );
    reg state;
    always @(posedge clk, posedge rst)
        begin
            if(rst)
                state <= 0;
            else
                state <= ~state;
        end
        
        
           assign DoClk = state;
           assign pulse = clk & DoClk;
endmodule
