`timescale 1ns / 1ps

module segment_7
(
  input [2:0] binary,
  output reg seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g
  
 );
 
  reg [0:6]segmentcode;
  always @(*)
  begin
  case(binary)
    3'b000: segmentcode = 7'b1111110;
    3'b001: segmentcode = 7'b0110000;
    3'b010: segmentcode = 7'b1101101;
    3'b011: segmentcode = 7'b1111001;
    3'b100: segmentcode = 7'b0110011;
    3'b101: segmentcode = 7'b1011011;
    
    default: segmentcode = 7'b1001111;
  endcase

    seg_a = segmentcode[0];
    seg_b = segmentcode[1];
    seg_c = segmentcode[2];
    seg_d = segmentcode[3];
    seg_e = segmentcode[4];
    seg_f = segmentcode[5];
    seg_g = segmentcode[6];
    
    end
endmodule