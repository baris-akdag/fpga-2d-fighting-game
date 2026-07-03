module render_layering
(
	input clk,
	input[9:0] next_x,
	input[9:0] next_y,
	input[9:0] char_x,
	input[7:0] background_pixel_color,
	input[7:0] char_pixel_color,
	output reg [7:0] pixel_color
);

reg[9:0]char_y = 10'd_200; 
reg[9:0]abs_x ;
reg[9:0]abs_y ;


always @(posedge clk) //renders the character and the background layering it together so that they dont overlap
begin

	abs_x <= next_x - char_x;
	abs_y <= next_y - char_y;
	
	if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
		pixel_color <= char_pixel_color;
		
	else
		pixel_color <= background_pixel_color;
		
end
endmodule