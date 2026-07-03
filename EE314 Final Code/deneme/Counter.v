module Counter #(parameter W = 4 ) // Default width of 4 bits
(
    input clk,
	 input[1:0] control, // 00 hold, 01 increment, 10 decrement. 11 reset
	 output reg[W-1:0] count //value of the counter
);

always @(posedge clk) 
begin

	if(control == 2'b01) 
		count <= count + 1'b1;	
		
	else if (control == 2'b10)
		count <= count - 1'b1;	
		
	else if (control == 2'b00)
		count <= count;
		
	else if (control == 2'b11)
		count <= 0;
		
end

endmodule