`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2020 19:06:53
// Design Name: 
// Module Name: DataMemory
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


module DM #(parameter N = 7)(
    douta, done,
    clka, ena, wea, addra, dina
    );
    
    input clka, ena, wea;
    input [N - 1 : 0] addra;
    input [31 : 0] dina;
    output reg [31 : 0] douta;
    output reg done;
    
    reg [31 : 0] datamemory[2 ** N - 1 : 0];
    integer i;
    
//   DataMemory datamemory (
//  .clka(clka),    // input wire clka
//  .ena(ena),      // input wire ena
//  .wea(wea),      // input wire [0 : 0] wea
//  .addra(addra),  // input wire [6 : 0] addra
//  .dina(dina),    // input wire [31 : 0] dina
//  .douta(douta)  // output wire [31 : 0] douta
//);


initial begin
        for(i = 0; i <= 2 ** N - 1; i = i + 1)begin
            datamemory[i] = 0;
        end
   end
   
    always@(posedge clka) begin
        if(ena) begin
            if(wea)begin
                douta <= dina;
                datamemory[addra] <= dina;
                done <= 0;
              end
            else begin
                douta <= datamemory[addra];
                done <= 1;
                end
         end
         else 
            done <= 0;
    end
endmodule
