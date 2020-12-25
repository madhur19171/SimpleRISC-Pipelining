`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2020 15:29:15
// Design Name: 
// Module Name: ALUDivision
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


module ALUDivision(
    input clk,
    input isDiv,
    input[31:0] A, B,
    output logic stall,
    output [31:0]Quo,
    output [31:0]Rem
    );
    
    logic aclken = 0, aresetn = 0, pulse = 0, pulse_state = 0, valid;
    
    typedef enum logic[2:0] {RST = 0, DIV1 = 1, DIV2 = 4, PULSE = 2, WAITING = 3, BAD = 3'bxxx} FSM_STATE;
    
    FSM_STATE state = RST, next;
    
    always_ff@(posedge clk)begin
        state <= next;
    end
    
    always_comb begin
        case(state)
            RST : next = isDiv ? DIV1 : RST;
            DIV1 : next = DIV2;
            DIV2 : next = PULSE;
            PULSE : next = WAITING;
            WAITING : next = valid ? RST : WAITING;
            default : next = BAD;
        endcase
    end
    
    always_comb begin
        if(state == RST)
            aclken = 0;
         else aclken = 1;
         
         if(state == RST  || state == WAITING && valid == 1)
            aresetn = 0;
         else aresetn = 1;
         
         if(state == DIV1 || state == DIV2)
            pulse = 1;
         else pulse = 0;
         
         if(state == RST && isDiv == 1 || state == DIV1 || state == DIV2 || 
            state == PULSE || state == WAITING && ~valid)
            stall = 1;
         else stall = 0;
    end
    
      div_gen_0 DIVIDE (
      .aclk(clk),                                      // input wire aclk
      .aclken(aclken),                                  // input wire aclken
      .aresetn(aresetn),                                // input wire aresetn
      .s_axis_divisor_tvalid(pulse),    // input wire s_axis_divisor_tvalid
      .s_axis_divisor_tdata(B),      // input wire [31 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(pulse),  // input wire s_axis_dividend_tvalid
      .s_axis_dividend_tdata(A),    // input wire [31 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(valid),          // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata({Quo, Rem})            // output wire [63 : 0] m_axis_dout_tdata
    );
endmodule
