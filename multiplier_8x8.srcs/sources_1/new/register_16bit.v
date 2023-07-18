`timescale 1ns / 1ps

module register_16bit
(
    input  clk,sclr_n,clk_ena,
    input [15:0]datain,
    output reg [15:0]reg_out
);

 always@(posedge clk or negedge sclr_n)
 begin
  if(clk_ena==1'b1&sclr_n==1'b0)
     reg_out<=16'b0;
  else if(clk_ena==1'b1&sclr_n==1'b1)
     reg_out<=datain;
  else
     reg_out<=reg_out;

 end
    
endmodule