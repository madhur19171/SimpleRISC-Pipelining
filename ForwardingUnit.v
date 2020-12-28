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
    
    //Keeping this in priority sequence of DM >> WB >> EXT is very important.
    //Consider two instructions i and j. i has been issued before j. Both instructions write into register 2.
    //If a different instruction comes after j which will read register 2, then rd will be in two pipelines. 
    //Naturally, the rd that is in a later pipeline stage will be a result of older instruction i.e instruction i.
    //So we want the data that has been written by instruction j.
    //So this data will be in earlier pipeline.
    //This is why we need to give priority to earlier pipeline stage data because they will be the latest data.
    //Eg. i is in EXT stage and j is in WB stage. next instruction requests data from register 2.
    //Now this rd is in both WB and EXT stage, so the data in WB will be newer data hence this has to be forwarded.
    
    always@(*)begin
        if(RP1_ALU == rd_DM && rd_DM != 0)
            A = result_DM;
        else if(RP1_ALU == rd_WB && rd_WB != 0)
            A = result_WB;
        else if(RP1_ALU == rd_EXT && rd_EXT != 0)
            A = result_EXT;
        else
            A = A_ALU;
            
            
        if(RP2_ALU == rd_DM  && rd_DM != 0)
            B = result_DM;
        else if(RP2_ALU == rd_WB && rd_WB != 0)
            B = result_WB;
        else if(RP2_ALU == rd_EXT  && rd_EXT != 0)
            B = result_EXT;   
        else
            B = B_ALU;
    end
endmodule
