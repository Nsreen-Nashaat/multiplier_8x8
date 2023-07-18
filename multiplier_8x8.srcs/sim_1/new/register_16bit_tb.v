`timescale 1ns / 1ps

module register_16bit_tb();

reg clk,sclr_n,clk_ena;
  reg [15:0]datain;
  wire [15:0]reg_out;

register_16bit dut(clk,sclr_n,clk_ena,datain,reg_out);

  always
   begin
    clk<=1'b1;
    #100;
    clk<=1'b0;
    #100;
   end

 initial 
 begin
  clk_ena=1'b1;
  sclr_n=1'b0;
  datain = $random;
  #200;
  
  clk_ena=1'b1;
  sclr_n=1'b1;
  datain = $random;
   #200;
   
  clk_ena=1'b0;
  sclr_n=1'b0;
  datain = $random;
   #200;
   
   clk_ena=1'b1;
     sclr_n=1'b1;
     datain = $random;
      #200;
 end

endmodule
