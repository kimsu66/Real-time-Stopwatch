module sec_counter( //19bit counter
    clk,
    reset,
    en,
    sec_count   //19bit count
);

parameter N = 19;

input clk;
input reset;
input [1:0] en; 
output reg [N-1:0] sec_count;


always @(posedge clk or negedge reset) begin
    if (~reset) sec_count <= 0;
	 else begin 
		if (en==2'b00) sec_count <=0;
    else begin 
      if (en==2'b01) sec_count <= sec_count+1'b1;
	 else begin 
		if (en==2'b10) sec_count <= sec_count;
    else;
    end
	 end
	 end
end 

endmodule