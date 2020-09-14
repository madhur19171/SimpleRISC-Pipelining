`timescale 1ns/1ns

module testbench;
   reg clk, rst;
   Wrapper DUT(clk, rst);
   always begin
     #5 clk = ~clk;
   end

   
   initial begin
      clk = 0;
      rst = 1;
      #10 rst = 0;
   end
//   initial begin
//      $dumpfile("IM.vcd");
//      $dumpvars;
//      #1000 $finish;
//   end
   
endmodule
