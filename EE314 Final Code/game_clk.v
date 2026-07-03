module game_clk //creates a 60ish herz clock for game logic ish part comes from the sync with the vga
(
	//input[9:0] next_y,
	input clk,
	input stop,
	input step,
	output reg game_clk
);

localparam hz60_clk = 0;
localparam step_clk = 1;

wire hz60;

clock_divider game_divider
(
	.clk(clk),
	.division_factor(20'd_420_000),
	.modded_clk(hz60)
);

always @(*)
begin
	
	case(stop)
		
		hz60_clk:
		begin
			game_clk <= hz60;
		end
		
		step_clk:
		begin
			game_clk <= step;
		end
		
	endcase
	
end

endmodule