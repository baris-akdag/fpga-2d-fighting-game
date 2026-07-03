module clock_divider  
(
    input clk,
	 input[31:0] division_factor, 
	 output reg modded_clk 
);

wire[31:0] count;
reg[1:0] control;
reg clock_value;

Counter #(.W(32)) thine_counter
(
.clk(clk),
.control(control),
.count(count)
);

always @(posedge clk) 
begin

	if(count != division_factor)
		begin
		control <= 2'b01;
		modded_clk <= clock_value;
		end
		
	else
		begin
		control <= 2'b11;
		modded_clk <= clock_value;
		clock_value <= ~clock_value;
		end
	
end


endmodule