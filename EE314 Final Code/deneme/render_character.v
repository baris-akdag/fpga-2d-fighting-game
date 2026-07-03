module render_character// unused old code
(
	input clk,
	input[3:0] char_state,
	input[9:0] next_x,
	input[9:0] next_y,
	input[9:0] char_x,
	output reg [7:0] char_pixel_color
);


localparam S_startup = 10;
localparam S_gameover = 11;
localparam S_idle = 1;
localparam S_right = 2;
localparam S_left = 3;
localparam S_attack_start = 4;
localparam S_attack_active = 5;
localparam S_attack_recovery = 6;
localparam S_dir_attack_start = 7;
localparam S_dir_attack_active  = 8;
localparam S_dir_attack_recovery  = 9;

reg[9:0]char_y = 10'd_200; 
reg[9:0]abs_x ;
reg[9:0]abs_y ;


always @(posedge clk) //renders character depending on where the current x coordinate
begin
	
	abs_x <= next_x - char_x;
	abs_y <= next_y - char_y;

//	if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
//				char_pixel_color <= 8'b_000_011_11;
//				
//			else
//				char_pixel_color <= 8'b_111_111_11;

	
	case(char_state)
		
		S_startup:
		begin
			char_pixel_color <= 8'b_111_111_11;
		end
		S_idle, S_right, S_left:
		begin
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
				char_pixel_color <= 8'b_000_011_11;
				
			else
				char_pixel_color <= 8'b_111_111_11;
		end
		
		S_attack_start, S_dir_attack_start:
		begin
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
				char_pixel_color <= 8'b_111_111_00;
				
			else
				char_pixel_color <= 8'b_111_111_11;
		end
		
		S_attack_active, S_dir_attack_active:
		begin
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
				char_pixel_color <= 8'b_111_000_00;
				
			else
				char_pixel_color <= 8'b_111_111_11;
		end
		
		S_attack_recovery, S_dir_attack_recovery:
		begin
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
				char_pixel_color <= 8'b_000_111_00;
				
			else
				char_pixel_color <= 8'b_111_111_11;
		end
		
	endcase
		
end

endmodule