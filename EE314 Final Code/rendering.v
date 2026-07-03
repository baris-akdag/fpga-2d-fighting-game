module rendering
(
	input clk,
	
	input char_hurtbox,
	input char2_hurtbox,
	
	input char_hitbox,
	input char2_hitbox,
	
	input char_stunbox,
	input char2_stunbox,
	
	input hp_pixel,
	input bp_pixel,
	input cd_pixel,
	
	input end_pixel,
	
	input background,
	input menu_pixel,
	input count_pixel,
	
	output reg [7:0] pixel_color
);


//depending on which pixel you are in give color accordingly 
always @(posedge clk) 
begin
	if (background) pixel_color <= 8'b_010_010_00;
	
	else if(char_hitbox) pixel_color <= 8'b_011_000_00;
	
	else if(char2_hitbox) pixel_color <= 8'b_011_000_00;
	
	else if(char_hurtbox) pixel_color <= 8'b_111_010_00;
	
	else if(char2_hurtbox) pixel_color <= 8'b_111_010_00;
	
	else if(char_stunbox) pixel_color <= 8'b_000_111_11;
	
	else if(char2_stunbox) pixel_color <= 8'b_000_111_11;
	
	else if(menu_pixel) pixel_color <= 8'b_000_000_00;
	
	else if(count_pixel) pixel_color <= 8'b_000_000_00;
	
	else if(hp_pixel) pixel_color <= 8'b_111_000_00;
	
	else if(bp_pixel) pixel_color <= 8'b_011_000_11;
	
	else if(cd_pixel) pixel_color <= 8'b_000_000_00;
	
	else if(end_pixel) pixel_color <= 8'b_000_000_00;
	
	else pixel_color <= 8'b_100_100_10 ;
end


endmodule