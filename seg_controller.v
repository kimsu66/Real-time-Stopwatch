module seg_controller(
    clk, reset,
    d,
    e,
    f,
    g,
    h,
    i,
    seg_sel,
    seg
);

input clk;
input reset;
input [3:0] d;
input [3:0] e;
input [3:0] f;
input [3:0] g;
input [3:0] h;
input [3:0] i;

output [7:0] seg;
output [5:0] seg_sel;

wire [9:0] dp_count;
wire [3:0] a;
wire dot;

counter U1_counter( // 10 bit counter
    .clk(clk),
    .reset(reset),
    .dp_count(dp_count)   // 10 bit count
);

dp_fsm U0_dp_fsm(
    .clk(clk),
    .reset(reset),
    .seg_sel(seg_sel),
    .dp_count(dp_count),
    .d(d),
    .e(e),
    .f(f),
    .g(g),
    .h(h),
    .i(i),
	 .a(a),
	 .dot(dot)
);

dec_7seg U2_dec_7seg(
    .a(a),
    .dot(dot),
    .seg(seg)
);

endmodule
