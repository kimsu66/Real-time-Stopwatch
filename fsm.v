module fsm(
    clk,
    reset,
    count,  //count value
    d,      //segment data in
    seg_sel //segment select
);

input clk;
input reset;
input [9:0] count;
output reg [3:0] d;
output reg [5:0] seg_sel;

reg [2:0] state, next_state;

parameter S0=3'b000;
parameter S1=3'b001;
parameter S2=3'b010;
parameter S3=3'b011;
parameter S4=3'b100;
parameter S5=3'b101;

//status register
always @ (posedge clk or posedge reset)
begin 
    if (reset) state <= S0;
    else state <= next_state;
end

//next state logic
always @(state or count) 
begin
    case(state)
    S0 : if(count == 10'h3FF) next_state = S1;
        else next_state <= S0;
    S1 : if(count == 10'h3FF) next_state = S2;
        else next_state = S1;
    S2 : if(count == 10'h3FF) next_state = S3;
        else next_state = S2;
    S3 : if(count == 10'h3FF) next_state = S4;
        else next_state <= S3;
    S4 : if(count == 10'h3FF) next_state = S5;
        else next_state = S4;
    S5 : if(count == 10'h3FF) next_state = S0;
        else next_state = S5;
    default: next_state = S0;
    endcase
end

//output logic
always @(state) begin
    if (state == S0) begin 
        seg_sel = 6'b10_0000;
        d = 4'h0;
    end
    if (state == S1) begin 
        seg_sel = 6'b01_0000;
        d = 4'h1;
    end
    if (state == S2) begin 
        seg_sel = 6'b00_1000;
        d = 4'h2;
    end
    if (state == S3) begin 
        seg_sel = 6'b00_0100;
        d = 4'h3;
    end
    if (state == S4) begin 
        seg_sel = 6'b00_0010;
        d = 4'h4;
    end
    if (state == S5) begin 
        seg_sel = 6'b00_0001;
        d = 4'h5;
    end
end

endmodule