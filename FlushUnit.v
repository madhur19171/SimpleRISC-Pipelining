`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.11.2020 18:37:49
// Design Name: 
// Module Name: FlushUnit
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


module FlushUnit(
    input clk,
    input isBranchTaken,
    output reg flush
    );
    
    localparam S0=0, S1=1, S2=2, S3=3;
    
    reg [1:0]state = 0, next;
    
    always@(posedge clk) begin
        state <= next;
    end
    
    always@(*)begin
        case(state)
            S0: next = isBranchTaken ? S1 : S0;
            S1: next = S2;
            S2: next = S3;
            S3: next = S0;
            default: next = S0;
        endcase
    end
    
    always@(*)begin
        if(state == S0 && isBranchTaken == 0 || state == S3)
            flush = 0;
        else
            flush = 1;
    end
endmodule
