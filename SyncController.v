`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2020 23:06:27
// Design Name: 
// Module Name: SyncController
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


module SyncController(
    input clk,
    input stop,
    input rst,
    output updatePC,
    output ReadIM,
    output ReadRF,
    output DMop,
    output WriteRF
    );
    parameter UPC = 0, RIM = 1, RRF = 2, DM = 3, WRF = 4;
    reg [2:0] state = 0;
    always @(posedge clk)
        if(rst)
            state <= 0;
        else if(stop & state == RRF)
           state <= state;
        else
            case(state)
                UPC : state <= RIM;
                RIM : state <= RRF;
                RRF : state <= DM;
                DM : state <= WRF;
                WRF : state <= UPC;
            endcase 
     assign updatePC = state == UPC;
     assign ReadIM = state == RIM;
     assign ReadRF = state == RRF;
     assign DMop = state == DM;
     assign WriteRF = state == WRF;
endmodule
