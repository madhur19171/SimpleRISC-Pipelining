`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.09.2020 19:28:33
// Design Name: 
// Module Name: Wrapper
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


module Wrapper(
    input sysclk, input rst
    );
    
    //Data Memory Interface Connectors
    wire DMclka, DMena, DMwea, DMdone;
    wire [6 : 0] DMaddra;
    wire [31:0] DMdina, DMdouta;
    
    //Instruction Memory Interface
    wire IMclka;
    wire [6 : 0] IMaddra;
    wire [31 : 0] IMdouta;
    
    Processor processor(
        .clk(sysclk), 
        .rst(rst),
        //DM Interface
        .DMclka(DMclka), .DMena(DMena), .DMwea(DMwea),
        .DMaddra(DMaddra), .DMdina(DMdina),
        .DMdouta(DMdouta), .DMdone(DMdone),
        
        //IM Interface
        .IMdouta(IMdouta),
        .IMclka(IMclka), .IMaddra(IMaddra)
    );
    
    DM datamemory(
    .clka(DMclka), .ena(DMena), .wea(DMwea),
    .addra(DMaddra), .dina(DMdina), 
    .douta(DMdouta), .done(DMdone)
    );
    
    IM instruction_memory(
    .clka(IMclka),
    .addra(IMaddra),
    .douta(IMdouta)
    );
endmodule
