`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2020 19:46:26
// Design Name: 
// Module Name: vio_wrapper_IM
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


module vio_wrapper_IM(
    input clk
    );
    wire clock, rst;
    reg [2 : 0] addr;
    wire [31:0] data;
    
    always @(posedge clock)
        addr = rst ? 3'd0 : addr + 1;
        
    FrequencyDivider divide(clk, rst, clock);
    
    InstructionMemory memory(.clka(clk), .addra(addr), .douta(data));
    
vio_0 your_instance_name (
  .clk(clk),                // input wire clk
  .probe_in0(data),    // input wire [31 : 0] probe_in0
  .probe_out0(rst)  // output wire [0 : 0] probe_out0
);
endmodule
