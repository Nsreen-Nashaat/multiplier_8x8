`timescale 1ns / 1ps

module mux_2_1_tb();

    reg [3:0] in_a , in_b;
    reg sel;
    wire [3:0] out;
    
    mux_2_1 dut
    (
    .in_a(in_a),
    .in_b(in_b),
    .sel(sel),
    .out(out)
    );
    
    initial 
    begin 
        in_a=$random; in_b=$random;
        sel = 0; 
        #200;
        sel = 1; in_a=$random; in_b=$random;
        #200;
        sel = 1; in_a=$random; in_b=$random;
        #200;
        sel = 0; in_a=$random; in_b=$random;
        #200;
        sel = 0; in_a=$random; in_b=$random;
        #100;
        sel = 1; in_a=$random; in_b=$random;
        #100;
        sel = 0; in_a=$random; in_b=$random;
        #100;
        sel = 1; in_a=$random; in_b=$random;
        
end 

endmodule
