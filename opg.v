module opg(clk,
  reset,
  start,
  start_p);
  
input clk;
input reset;
input start;
  
output reg start_p;

reg start_buff;

//first block
always @(posedge clk or posedge reset)
begin 
  if (reset) 
    start_buff<=0;
  else
    start_buff<=start;
end

//second block
always @(posedge clk or posedge reset)
begin 
  if (reset)
    start_p<=0;
  else
    begin
    if (start_buff==0 && start ==1) 
      start_p<=1;
    else
      start_p<=0;
  end
end

endmodule     
