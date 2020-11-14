`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2020 19:47:36
// Design Name: 
// Module Name: IM
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


module IM #(parameter N = 7)(
    input clka,
    input[N - 1 : 0] addra,
    output reg [31:0] douta = 0
    );
    //InstructionMemory instruction_memory(.clka(clka), .douta(douta), .addra(addra));
    
    reg [31 : 0] instructionmemory[2 ** N - 1 : 0];
    
    initial
        $readmemb("Prime Check.mem", instructionmemory);
    
    always @(posedge clka) begin
        douta <= instructionmemory[addra];
    end
endmodule
