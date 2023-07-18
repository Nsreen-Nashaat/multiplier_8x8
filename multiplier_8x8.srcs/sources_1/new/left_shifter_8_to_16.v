`timescale 1ns / 1ps

module left_shifter_8_to_16 (
  input [7:0] data_in,
  input [1:0] shift_cntrl,
  output reg [15:0] data_out
);
  reg [15:0] var = 16'b0;
   
  always @(*) begin
    case (shift_cntrl)
      // No shift
      2'b00:begin 
      var= {8'b0,data_in};
      data_out = var;
      end  
      // 4-bit shift left
      2'b01:begin 
      var= {8'b0,data_in};
      data_out = var << 4;
      end 
      // 8-bit shift left
      2'b10:begin 
      var= {8'b0,data_in};
      data_out = var <<8;
      end 
      // No shift
      2'b11:begin 
      var= {8'b0,data_in};
      data_out = var;
      end
       
      default: data_out = {8'b0,data_in}; // Default case (no shift)
    endcase
  end

endmodule
