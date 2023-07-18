`timescale 1ns / 1ps

module adder_16bit
(
  input  wire [15:0] a,b,
  output reg [15:0] sum
);
    always@(*)
    begin
        sum = a+b;
    end
endmodule