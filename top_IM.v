`timescale 1ms / 1ms
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2020 21:49:15
// Design Name: 
// Module Name: top_IM
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


module IM(
    input clka,
    input[6 : 0] addra,
    output[31:0] douta
    );
    InstructionMemory instruction_memory(.clka(clka), .douta(douta), .addra(addra));
endmodule
