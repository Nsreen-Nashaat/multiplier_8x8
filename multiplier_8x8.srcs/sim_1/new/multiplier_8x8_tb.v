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

  // Clock generation
  always
    begin
     clk<=1'b1;
     #50;
     clk<=1'b0;
     #50;
    end

  // Initialize
  initial begin
    start = 0;
    reset_a =0;
    clk = 0;
    dataa = $random;
    datab = $random;
    #2;
    //  Multiplication of 10 and 5
    reset_a = 1 ;
     start = 1;
     dataa = 8'b00110010; 
     datab = 8'b00001010;
   
   
    #100	
   
    start = 0; 
    #400;

    // Check the result
    $display("Result: %d", product8_8);
    
    start = 0;
    reset_a =0;
    dataa = 8'b00000000;
    datab = 8'b00000000;
    #48;
    start = 1;
    #100;
    
    // Test scenario 2: Multiplication of 7 and 3
    reset_a =1;
     dataa = 8'b00000111; // 7
       datab = 8'b00000011; // 3 
     
    // Start 
    

    // Wait to complete multiplication
    #100;
    start = 0;
    // Wait to show result
    #300;

    // Check the result
    $display("Result: %d", product8_8);
    //$monitor($time, " count_out='b%x", dut.multiplier_8x8_tb.count_out);
        start = 0;
        reset_a =0;
        clk = 0;
        dataa = 8'b00000000;
        datab = 8'b00000000;
        #2;
        
        
        // Test scenario 2: Multiplication of 7 and 3
        reset_a =1;
        dataa = 8'b00001010; // 10
        datab = 8'b00000101; // 5

        // Start 
        start = 1;
    
        // Wait to complete multiplication
        #100;
        start = 0;
        // Wait to show result
        #300;
    
        // Check the result
        $display("Result: %d", product8_8);
    

  end
endmodule