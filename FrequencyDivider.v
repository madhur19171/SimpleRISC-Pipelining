`timescale 1ns / 1ps



module FrequencyDivider(
    input clk,
    output reg clock = 0
    );
    parameter N = 31;
    parameter limit = 2500000;
    //parameter limit = 27'd1250;
    reg [N:0] count; 
    wire clk_5M; 
    
    
        clk_wiz_0 divider
   (
    // Clock out ports
    .clk_out1(clk_5M),     // output clk_out1
   // Clock in ports
    .clk_in1(clk));   
    
    
    reg [31:0] count_state = 0, count_next = 0;
    
    always @(posedge clk_5M)
        if(count_next == limit/2)begin
                count_state <= 0;
                clock <= ~clock;
            end
        else
            begin
                count_state <= count_next;
                clock <= clock;
            end
            
    always @(*)
        count_next <= count_state + 1;
        
        
endmodule
