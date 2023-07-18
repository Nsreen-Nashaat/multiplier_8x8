`timescale 1ns / 1ps

module mux_2_1
(
    input [3:0] in_a, in_b,
    input sel,
    output reg [3:0] out
);

always @(*)
    begin
      //out = 'b0;
      if(sel == 0)
        out = in_a;
      else
        out = in_b;
    end  
  

endmodule