module top(
    clk,
    reset,
    start,
    stop,
    seg,
    seg_sel
);

input clk;
input reset;
input start;
input stop;
output [5:0] seg_sel;
output [7:0] seg;

wire [3:0] d;
wire [3:0] e;
wire [3:0] f;
wire [3:0] g;
wire [3:0] h;
wire [3:0] i;

stopwatch_top stopwatch_top(
    .clk(clk),
    .reset(reset),
    .start(start_p),
    .stop(stop),
    .d(d),
    .e(e),
    .f(f),
    .g(g),
    .h(h),
    .i(i)
);

seg_controller seg_controller(
    .clk(clk),
    .reset(reset),
    .seg(seg),
    .seg_sel(seg_sel),
    .d(d),
    .e(e),
    .f(f),
    .g(g),
    .h(h),
    .i(i)
);

opg opg(
	  .clk(clk),
	  .reset(~reset),
	  .start(~start),
	  .start_p(start_p)
);

endmodule