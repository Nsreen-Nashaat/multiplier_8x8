`timescale 1ns / 1ps

module t_ff
(
    input clk, reset_n,
    output q, nq
);

    reg state;
       
always @ (posedge clk or negedge reset_n)
begin
    if(~reset_n)
        state <= 1'b0;
    else
        state <= ~state;
end

    assign q = state;
    assign nq = ~state;

endmodule