`timescale 1ns / 1ps

module multiplier_controller
(
    input clk, reset_a, 
    input start,
    input [1:0] count,
    output reg [1:0] input_sel, shift_sel,
    output reg [2:0] state_out,
    output reg done, clk_ena, sclr_n
);

    reg [2:0] current_state ;
    localparam idle = 3'b000;
    localparam lsb = 3'b001;
    localparam mid = 3'b010;
    localparam msb = 3'b011;
    localparam calc_done = 3'b100;
    localparam err = 3'b101;
    
    always @(posedge clk or negedge reset_a)
    begin
    if(!reset_a)
        current_state <= idle;
    else
        current_state <= state_out;
    end
    
    always @(*)
    begin
        state_out = idle;
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
                state_out = lsb;
                done = 0;
                clk_ena = 1;
                sclr_n = 0;
            end
            else 
            begin
                state_out = idle;
                done = 0;
                clk_ena = 0;
                sclr_n = 1;
            end
        end
            
        lsb:
        begin
            if(start == 0 && count == 2'b00 )
            begin
                state_out = mid;
                input_sel = 2'b00;
                shift_sel = 2'b00;
                done = 0;
                clk_ena = 1;
                sclr_n = 1;
            end
            else
            begin
                state_out = err;
                done = 0;
                clk_ena = 0;
                sclr_n = 1;
            end
        end
             mid:
               begin
                   if(start == 0 && count == 2'b01 )
                   begin
                       state_out = mid;
                       input_sel = 2'b10;
                       shift_sel = 2'b01;
                       done = 0;
                       clk_ena = 1;
                       sclr_n = 1;
                   end
                   else if(start ==0 && count == 2'b10 )
                   begin
                       state_out = msb;
                       input_sel = 2'b10;
                       shift_sel = 2'b01;
                       done = 0;
                       clk_ena = 1;
                       sclr_n = 1;
                   end
                   else 
                   begin
                      state_out = err;
                      done = 0;
                      clk_ena = 0;
                      sclr_n = 1;
                   end
              end
              msb:
              begin
                 if(start ==0 && count == 2'b11 )
                 begin
                     state_out = calc_done;
                     input_sel = 2'b11;
                     shift_sel = 2'b10;
                     done = 0;
                     clk_ena = 1;
                     sclr_n = 1;
                 end
                 else 
                 begin
                    state_out = err;
                    done = 0;
                    clk_ena = 0;
                    sclr_n = 1;
                 end
            end
            calc_done:
              begin
                 if(start)
                 begin
                     state_out = err;
                     done = 0;
                     clk_ena = 1;
                     sclr_n = 1;
                 end
                 else 
                 begin
                    state_out = idle;
                    done = 1;
                    clk_ena = 0;
                    sclr_n = 1;
                 end
            end
      err:
          begin
             if(start == 0)
             begin
                 state_out = err;
                 done = 0;
                 clk_ena = 0;
                 sclr_n = 1;
             end
             else 
             begin
                state_out = lsb;
                done = 0;
                clk_ena = 1;
                sclr_n = 0;
             end
         end
         default:
         begin
            state_out = idle;
          end            
        endcase
    end

endmodule