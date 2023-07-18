`timescale 1ns / 1ps

module multiplier_controller_tb();
 reg clk,reset_a,start;
 reg [1:0]count;
 wire [1:0]input_sel;
 wire [1:0]shift_sel;
 wire [2:0]state_out;
 wire done,clk_ena,sclr_n;

multiplier_controller dut
(
    .clk(clk),
    .reset_a(reset_a),
    .start(start),
    .count(count),
    .input_sel(input_sel),
    .shift_sel(shift_sel),
    .state_out(state_out),
    .done(done),
    .clk_ena(clk_ena),
    .sclr_n(sclr_n)
    );

 always
  begin
   clk<=1'b1;
   #50;
   clk<=1'b0;
   #50;
  end

initial 
begin
 reset_a=1'b0;   start =0;
  #2;
    reset_a=1'b1;
  #100;
    start=1'b1;
   #100
    start= 0;   count = 2'b00;
  #100;
    start= 0;   count = 2'b10;
  #100;
    start= 0;   count=2'b11;
  #100;
  start= 0;  
  #100;
  start= 1;  
  #100;
   start= 0;  
  #100;
   start= 1;  
  #100;
end

endmodule
