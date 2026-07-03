module hp_bp_renderer
(
	input clk,
	
	input [1:0] char_hp,
	input [1:0] char2_hp,
	input [1:0] char_bp,
	input [1:0] char2_bp,
	
	input[9:0] next_x,
	input[9:0] next_y,
	
	input[3:0] char_state,
	input[3:0] char2_state,
	
	output reg hp_pixel,
	output reg bp_pixel

);

localparam S_startup = 0;
localparam S_countdown = 11;
localparam S_gameover = 10;
localparam S_idle = 1;
localparam S_right = 2;
localparam S_left = 3;
localparam S_attack_start = 4;
localparam S_attack_active = 5;
localparam S_attack_recovery = 6;
localparam S_dir_attack_start = 7;
localparam S_dir_attack_active  = 8;
localparam S_dir_attack_recovery  = 9;
localparam S_hitstun = 12;
localparam S_blockstun = 13;

reg[9:0] hp_length, bp_length, hp2_length, bp2_length ;

always @(posedge clk) //background of menu
	
begin  

	hp_pixel <= 1'b0;	
	bp_pixel <= 1'b0;	
	
	hp_length <= 160 - (40 * char_hp);
	bp_length <= 160 - (40 * char_bp);
	
	hp2_length <= 600 - (40 * char2_hp);
	bp2_length <= 600 - (40 * char2_bp);
	
	
	
	case(char_state)
	
	S_startup, S_countdown, S_gameover:
	begin
		hp_pixel <= 1'b0;	
		bp_pixel <= 1'b0;	
	end
	
	default:
	begin
	
		if ((next_y > 80 && next_y <= 100) && (next_x > 40 && next_x <= hp_length))
			hp_pixel <= 1'b1;
		
		if ((next_y > 120 && next_y <= 140) && (next_x > 40 && next_x <= bp_length ))
			bp_pixel <= 1'b1;
			
		if ((next_y > 80 && next_y <= 100) && (next_x > 480 && next_x <= hp2_length ))
			hp_pixel <= 1'b1;
		
		if ((next_y > 120 && next_y <= 140) && (next_x > 480 && next_x <= bp2_length ))
			bp_pixel <= 1'b1;
		
	end
	endcase
end

endmodule
