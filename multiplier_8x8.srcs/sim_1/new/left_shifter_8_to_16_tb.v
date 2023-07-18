`timescale 1ns / 1ps

module left_shifter_8_to_16_tb;

  reg [7:0] data_in;
  reg [1:0] shift_cntrl;
  wire [15:0] data_out;

  left_shifter_8_to_16 uut 
  (
    .data_in(data_in),
    .shift_cntrl(shift_cntrl),
    .data_out(data_out)
  );

  initial begin
    $monitor("data_in = %b, shift_cntrl = %b, data_out = %b", data_in, shift_cntrl, data_out);
    
    // Test case 1: No shift
    data_in = 8'b10101010;
    shift_cntrl = 2'b00;
    #10;

    // Test case 2: 4-bit shift left
    data_in = 8'b10101010;
    shift_cntrl = 2'b01;
    #10;

    // Test case 3: 8-bit shift left
    data_in = 8'b10101010;
    shift_cntrl = 2'b10;
    #10;

    // Test case 4: No shift
    data_in = 8'b10101010;
    shift_cntrl = 2'b11;
    #10;

    // Additional test cases can be added here

    $finish;
  end

endmodule
