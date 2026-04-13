module counter( //10bit counter
    clk,
    reset,
    dp_count   //10bit count
);

parameter N = 10;

input clk;
input reset;
output reg [N-1:0] dp_count;

always @(posedge clk or negedge reset) begin
    if (reset==0) dp_count <= 0;
    else dp_count <= dp_count+1'b1; 
end

endmodule