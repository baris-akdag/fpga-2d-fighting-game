module random_input_generator
(
	input clk,
	output reg right,
	output reg left,
	output reg attack
);

wire[15:0] rand_string;

clock_divider oneHz2
(
.clk(clk),
.division_factor(13),
.modded_clk(rand_clk)
);

LFSR rando
(
.clk(rand_clk),
.state(rand_string),
);

always @(posedge rand_clk)
begin
	right <= rand_string[15];
	left <= rand_string[10];
	attack <= rand_string[5];
end
endmodule