`timescale 1ns / 1ps

module multiplier_8x8
(
    input start,reset_a,clk,
    input[7:0]dataa,
    input[7:0]datab,
    output done_flag,
    output [15:0]product8_8,
    output seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g
);

    wire [1:0] sel;
    wire [3:0] aout;
    wire [3:0] bout;
    wire [7:0] product;
    wire [1:0] shift;
    wire [15:0] shift_out;
    wire [15:0] sum;
    wire [1:0] count;
    wire [2:0] state_out;
    wire clk_ena;
    wire sclr_n;
    //wire [0:6] segmentcode;
    
    mux_2_1 a1
    (
        .in_a(dataa[3:0]),
        .in_b(dataa[7:4]),
        .sel(sel[1]),
        .out(aout[3:0])
     );
     
    multiplier_4bit b1
    (
        .a(aout[3:0]),
        .b(bout[3:0]),
        .result(product[7:0])
    );

    mux_2_1 a2
    (
        .in_a(datab[3:0]),
        .in_b(datab[7:4]),
        .sel(sel[0]),
        .out(bout[3:0])
    );

    left_shifter_8_to_16 s1
    (
        .data_in(product[7:0]),
        .shift_cntrl(shift[1:0]),
        .data_out(shift_out[15:0])
    );
    
    register_16bit q1
    (
        .clk(clk),
        .sclr_n(sclr_n),
        .clk_ena(clk_ena),
        .datain(sum[15:0]),
        .reg_out(product8_8[15:0])
    );
    
    adder_16bit k1
    (
        .a(shift_out[15:0]),
        .b(product8_8[15:0]),
        .sum(sum[15:0])
    );
    
    
    
    multiplier_controller w1
    (
        .clk(clk),
        .reset_a(reset_a),
        .start(start),
        .count(count[1:0]),
        .input_sel(sel[1:0]),
        .shift_sel(shift[1:0]),
        .state_out(state_out[2:0]),
        .done(done_flag),
        .clk_ena(clk_ena),
        .sclr_n(sclr_n)
    );
    
    asyn_2_1_counter r1
    (
        .clk(clk),
        .aclr_n(!start),
        .count_out(count[1:0])
     );
     
    segment_7 t1
    (
        .binary(state_out[2:0]),
        .seg_a(seg_a),
        .seg_b(seg_b),
        .seg_c(seg_c),
        .seg_d(seg_d),
        .seg_e(seg_e),
        .seg_f(seg_f),
        .seg_g(seg_g)
     );

endmodule
