module multiplier_controller
(
    input clk, reset_a, 
    input start,
    input [1:0] count,
    output reg [1:0] input_sel, shift_sel,
    output reg [2:0] state_out,
    output reg done, clk_ena, sclr_n
);

    reg [2:0] current_state, next_state ;
    localparam idle      = 3'b000;
    localparam lsb       = 3'b001;
    localparam mid       = 3'b010;
    localparam msb       = 3'b011;
    localparam calc_done = 3'b100;
    localparam err       = 3'b101;
    
    always @(posedge clk or negedge reset_a)
    begin
        if(!reset_a)
            current_state <= idle;
        else
            current_state <= next_state;
        end
    
    always @(*)
    begin
        state_out = 3'b000;
        input_sel = 2'b00;
        shift_sel = 2'b00;
        done =0;
        clk_ena = 0;
        sclr_n = 0;
    
        case (current_state)
        idle:
        begin
            if(start == 1 )
            begin
                done = 0;
                clk_ena = 1;
                sclr_n = 0;
                next_state = lsb;
            end
            else 
            begin
                done = 0;
                clk_ena = 0;
                sclr_n = 1;
		        next_state = idle;
            end
        end
 	
        lsb:
        begin
		  state_out = 3'b001;
          if(start == 0 && count == 2'b00 )
          begin
                input_sel = 2'b00;
                shift_sel = 2'b00;
                done = 0;
                clk_ena = 1;
                sclr_n = 1;
                next_state = mid;
           end
           else
           begin
                done = 0;
                clk_ena = 0;
                sclr_n = 1;
                next_state = err;
           end
        end
	
         mid:
           begin
               state_out = 3'b010;
               if(start == 0 && count == 2'b01 )
               begin
                   input_sel = 2'b10;
                   shift_sel = 2'b01;
                   done = 0;
                   clk_ena = 1;
                   sclr_n = 1;
                   next_state = mid;
               end
               else if(start ==0 && count == 2'b10 )
               begin
                   input_sel = 2'b10;
                   shift_sel = 2'b01;
                   done = 0;
                   clk_ena = 1;
                   sclr_n = 1;
                   next_state = msb;
               end
               else 
               begin
                  done = 0;
                  clk_ena = 0;
                  sclr_n = 1;
               end
          end
				  
          msb:
          begin
             state_out = 3'b011;
             if(start ==0 && count == 2'b11 )
             begin
                 input_sel = 2'b11;
                 shift_sel = 2'b10;
                 done = 0;
                 clk_ena = 1;
                 sclr_n = 1;
                 next_state = calc_done;
             end
             else 
             begin
                done = 0;
                clk_ena = 0;
                sclr_n = 1;
                next_state = err;
             end
        end
				
        calc_done:
          begin
             state_out = 3'b100;
             if(start)
             begin
                 done = 0;
                 clk_ena = 1;
                 sclr_n = 1;
                 next_state = err;
             end
             else 
             begin
                done = 1;
                clk_ena = 0;
                sclr_n = 1;
                next_state = idle;
             end
        end		
				
      err:
          begin
			 state_out = 3'b101;
             if(start == 0)
             begin
                 done = 0;
                 clk_ena = 0;
                 sclr_n = 1;
			     next_state = err;
             end
             else 
             begin
                done = 0;
                clk_ena = 1;
                sclr_n = 0;
		        next_state = lsb;
             end
         end
		
         default:
         begin
             next_state = current_state ;
          end            
        endcase
    end

endmodule