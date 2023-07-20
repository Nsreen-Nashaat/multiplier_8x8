`timescale 1ns / 1ps

module multiplier_8x8_tb;

 // Inputs
  reg start;
  reg reset_a;
  reg clk;
  reg [7:0] dataa;
  reg [7:0] datab;

  // Outputs
  wire done_flag;
  wire [15:0] product8_8;
  wire seg_a, seg_b, seg_c, seg_d, seg_e, seg_f,seg_g;

  // Instantiate the top module
  multiplier_8x8 dut 
  (
    .start(start),
    .reset_a(reset_a),
    .clk(clk),
    .dataa(dataa),
    .datab(datab),
    .done_flag(done_flag),
    .product8_8(product8_8),
    .seg_a(seg_a),
    .seg_b(seg_b),
    .seg_c(seg_c),
    .seg_d(seg_d),
    .seg_e(seg_e),
    .seg_f(seg_f),
    .seg_g(seg_g)
  );

			 
    initial
    begin
        dataa = 8'b11111111;
        datab = 8'b11111111;
        clk = 0;
        reset_a = 0;
        start = 0;
        #84
        reset_a = 1;
        start = 1;
        #42
        start = 0;
    end


    always
    begin
    #35 clk = ~ clk;
    end
    initial #500 $finish;

endmodule

