module dp_fsm(
    clk,
    reset,
    dp_count,  //count value
    d,      //segment data in
    e,
    f,
    g,
    h,
    i,
    seg_sel, //segment select
    a,
    dot
);

input clk;
input reset;
input [9:0] dp_count;
input [3:0] d;
input [3:0] e;
input [3:0] f;
input [3:0] g;
input [3:0] h;
input [3:0] i;

output reg [3:0] a;
output reg dot;
output reg [5:0] seg_sel;

reg [2:0] state, next_state;

parameter S0=3'b000;
parameter S1=3'b001;
parameter S2=3'b010;
parameter S3=3'b011;
parameter S4=3'b100;
parameter S5=3'b101;

//status register
always @ (posedge clk or negedge reset)
begin 
    if (~reset) state <= S0;
    else state <= next_state;
end

//next state logic
always @(state or dp_count) 
begin
    case(state)
    S0 : if(dp_count == 10'b11_1111_1111) next_state <= S1;
        else next_state <= S0;
    S1 : if(dp_count == 10'b11_1111_1111) next_state <= S2;
        else next_state <= S1;
    S2 : if(dp_count == 10'b11_1111_1111) next_state <= S3;
        else next_state <= S2;
    S3 : if(dp_count == 10'b11_1111_1111) next_state <= S4;
        else next_state <= S3;
    S4 : if(dp_count == 10'b11_1111_1111) next_state <= S5;
        else next_state <= S4;
    S5 : if(dp_count == 10'b11_1111_1111) next_state <= S0;
        else next_state <= S5;
    default: next_state <= S0;
    endcase
end

//output logic
always @(state) begin
    if (state == S0) begin 
        seg_sel = 6'b10_0000;
        a = i;
		  dot=0;
    end
    if (state == S1) begin 
        seg_sel = 6'b01_0000;
        a = h;
        dot=1;
    end
    if (state == S2) begin 
        seg_sel = 6'b00_1000;
        a = g;
		  dot=0;
    end
    if (state == S3) begin 
        seg_sel = 6'b00_0100;
        a = f;
        dot=1;
    end
    if (state == S4) begin 
        seg_sel = 6'b00_0010;
        a = e;
		  dot=0;
    end
    if (state == S5) begin 
        seg_sel = 6'b00_0001;
        a = d;
		  dot=0;
    end
end

endmodule
