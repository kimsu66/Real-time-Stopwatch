module stopwatch_fsm (
    clk,
    reset,
    start,
    stop,
    en
);

input clk,reset;
input start;
input stop;
output reg [1:0] en;

reg [1:0] state;
reg [1:0] nextstate;

parameter T0 = 2'b00; //base
parameter T1 = 2'b01; //countup
parameter T2 = 2'b10; //stop


//state register
always @(posedge clk or negedge reset) begin
    if(~reset) state<=T0;
    else state <= nextstate;
end

//nextstate logic
always @(state or start or stop) begin
    if(~stop)
        nextstate = T0;
    else begin
        case (state)
            T0 : if(start==1)   nextstate = T1;
                 else           nextstate = T0;
            T1 : if(start==1)   nextstate = T2;
                 else           nextstate = T1;
            T2 : if(start==1)   nextstate = T1;
		 else if(stop==1) nextstate = T0;
                 else           nextstate = T2; 
        endcase
    end
end

//ouput logic
always @(state) begin
    case (state)
        T1 : en = T1;
        T2 : en = T2;
        default: en = T0;
    endcase
end

endmodule
