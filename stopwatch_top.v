module stopwatch_top(
    clk,
    reset,
    start,
    stop,
    d,
    e,
    f,
    g,
    h,
    i
);

input clk;
input reset;
input start;
input stop;

output [3:0] d;
output [3:0] e;
output [3:0] f;
output [3:0] g;
output [3:0] h;
output [3:0] i;

wire [18:0] sec_count;
wire [1:0] en;

sec_counter sec_counter(
    .clk(clk),
    .reset(reset),
    .en(en),
    .sec_count(sec_count)
);

stopwatch_fsm stopwatch_fsm(
    .clk(clk),
    .reset(reset),
    .start(start),
    .stop(stop),
    .en(en)
);

timer timer(
    .clk(clk),
    .reset(reset),
    .sec_count(sec_count),
    .stop(stop),
    .d(d),
    .e(e),
    .f(f),
    .g(g),
    .h(h),
    .i(i)
);

endmodule