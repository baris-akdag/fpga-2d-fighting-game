module layering
(
	input clk,
	input[9:0] next_x,
	input[9:0] next_y,
	
	input[9:0] char_x,
	input[9:0] char2_x,
	
	input[3:0] char_state,
	input[3:0] char2_state,
	
	output reg char_hurtbox,
	output reg char2_hurtbox,
	
	output reg char_hitbox,
	output reg char2_hitbox,
	
	output reg char_stunbox,
	output reg char2_stunbox,
	
	output reg background

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

reg signed [9:0]char_y = 10'd_200; 
reg signed [9:0]abs_x, abs2_x ;
reg signed [9:0]abs_y ;


always@(posedge clk)
begin

	abs_x <= next_x - char_x;
	abs_y <= next_y - char_y;
	
	abs2_x <= next_x - char2_x;
	
	//calculate where the background is
	case(char_state)
		S_startup, S_countdown, S_gameover: background <= 1'b0;
		
		default:
		begin
			if (next_y > 440 && next_y <= 470)
			begin
				background <= 1'b1;
			end
			
			else background <= 1'b0;
		end
	endcase
	
	//calculate where the character 1 is depending on state
	case(char_state)
		
		S_startup, S_countdown, S_gameover:
		begin
			char_hurtbox <= 1'b0;
			char_hitbox <= 1'b0;
			char_stunbox <= 1'b0;
		end
		
		S_hitstun:
		begin 
			char_hitbox <= 1'b0;
			char_hurtbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
				char_stunbox <= 1'b1;
			else
				char_stunbox <= 1'b0;
		end
		
		S_blockstun:
		begin 
			char_hitbox <= 1'b0;
			char_hurtbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
			begin
				if((abs_y > 40 && abs_y <= 200) && (abs_x > 20 && abs_x <= 44)) 
					char_stunbox <= 1'b0;
				else 
					char_stunbox <= 1'b1;
			end
			else
				char_stunbox <= 1'b0;
		end
		
		
		S_idle, S_right, S_left:
		begin
			char_hitbox <= 1'b0;
			char_stunbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
				char_hurtbox <= 1'b1;
			else
				char_hurtbox <= 1'b0;
		end
		
		S_attack_start:
		begin
			char_hitbox <= 1'b0;
			char_stunbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 70))
				char_hurtbox <= 1'b1;
			else
				char_hurtbox <= 1'b0;
		end
		
		S_dir_attack_start:
		begin
			char_hitbox <= 1'b0;
			char_stunbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 70))
				char_hurtbox <= 1'b1;
		
			else
				char_hurtbox <= 1'b0;
		end

		S_attack_active:
		begin
			char_stunbox <= 1'b0;
			
			if((abs_y > 200 && abs_y <= 240) && (abs_x > 64 && abs_x <= 128))	
				char_hitbox <= 1'b1;
			else
				char_hitbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
				char_hurtbox <= 1'b1;
			else if((abs_y > 180 && abs_y <= 240) && (abs_x > 64 && abs_x <= 108))	
				char_hurtbox <= 1'b1;
			else
				char_hurtbox <= 1'b0;
		end
		
		S_dir_attack_active:
		begin
			char_stunbox <= 1'b0;
		
			if((abs_y > 180 && abs_y <= 240) && (abs_x > 64 && abs_x <= 104))
				char_hitbox <= 1'b1;	
			else if((abs_y > 100 && abs_y <= 160) && (abs_x > 64 && abs_x <= 104))
				char_hitbox <= 1'b1;
			else
				char_hitbox <= 1'b0;
				
				
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
				char_hurtbox <= 1'b1;	
			else if((abs_y > 100 && abs_y <= 240) && (abs_x > 64 && abs_x <= 90))
				char_hurtbox <= 1'b1;				
			else
				char_hurtbox <= 1'b0;
		end

		S_attack_recovery:
		begin
			char_hitbox <= 1'b0;
			char_stunbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
				char_hurtbox <= 1'b1;
			else if((abs_y > 180 && abs_y <= 240) && (abs_x > 64 && abs_x <= 108))	
				char_hurtbox <= 1'b1;
			else
				char_hurtbox <= 1'b0;
		end
		
		S_dir_attack_recovery:
		begin
			char_hitbox <= 1'b0;
			char_stunbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs_x > 0 && abs_x <= 64))
				char_hurtbox <= 1'b1;	
			else if((abs_y > 100 && abs_y <= 240) && (abs_x > 64 && abs_x <= 90))
				char_hurtbox <= 1'b1;				
			else
				char_hurtbox <= 1'b0;	
		end
		
	endcase


	//calculate where the character 2 is depending on state
	case(char2_state)
		
		S_startup, S_countdown, S_gameover:
		begin
			char2_hurtbox <= 1'b0;
			char2_hitbox <= 1'b0;
			char2_stunbox <= 1'b0;
		end
		
		S_hitstun:
		begin 
			char2_hitbox <= 1'b0;
			char2_hurtbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs2_x > 0 && abs2_x <= 64))
				char2_stunbox <= 1'b1;
			else
				char2_stunbox <= 1'b0;
		end
		
		
		S_blockstun:
		begin 
			char2_hitbox <= 1'b0;
			char2_hurtbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs2_x > 0 && abs2_x <= 64))
			begin
				if((abs_y > 40 && abs_y <= 200) && (abs2_x > 20 && abs2_x <= 44)) 
					char2_stunbox <= 1'b0;
				else 
					char2_stunbox <= 1'b1;
			end
			else
				char2_stunbox <= 1'b0;
		end
		
		
		S_idle, S_right, S_left:
		begin
			char2_hitbox <= 1'b0;
			char2_stunbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs2_x > 0 && abs2_x <= 64))
				char2_hurtbox <= 1'b1;
		
			else
				char2_hurtbox <= 1'b0;
		end
		
		S_attack_start:
		begin
			char2_hitbox <= 1'b0;
			char2_stunbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs2_x > -6 && abs2_x <= 64))
				char2_hurtbox <= 1'b1;
		
			else
				char2_hurtbox <= 1'b0;
		end
		
		S_dir_attack_start:
		begin
			char2_hitbox <= 1'b0;
			char2_stunbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs2_x > -6 && abs2_x <= 64))
				char2_hurtbox <= 1'b1;
		
			else
				char2_hurtbox <= 1'b0;
		end

		S_attack_active:
		begin
			char2_stunbox <= 1'b0;
			
			if((abs_y > 200 && abs_y <= 240) && (abs2_x > -64 && abs2_x <= 0))	
				char2_hitbox <= 1'b1;
			else
				char2_hitbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs2_x > 0 && abs2_x <= 64))
				char2_hurtbox <= 1'b1;
			else if((abs_y > 180 && abs_y <= 240) && (abs2_x > -44 && abs2_x <= 0))	
				char2_hurtbox <= 1'b1;
			else
				char2_hurtbox <= 1'b0;
		end
		
		S_dir_attack_active:
		begin
			char2_stunbox <= 1'b0;
			
			if((abs_y > 180 && abs_y <= 240) && (abs2_x > -40 && abs2_x <= 0))
				char2_hitbox <= 1'b1;	
			else if((abs_y > 100 && abs_y <= 160) && (abs2_x > -40 && abs2_x <= 0))
				char2_hitbox <= 1'b1;
			else
				char2_hitbox <= 1'b0;
				
				
			if((abs_y > 0 && abs_y <= 240) && (abs2_x > 0 && abs2_x <= 64))
				char2_hurtbox <= 1'b1;	
			else if((abs_y > 100 && abs_y <= 240) && (abs2_x > -26 && abs2_x <= 0))
				char2_hurtbox <= 1'b1;				
			else
				char2_hurtbox <= 1'b0;
		end

		S_attack_recovery:
		begin
			char2_hitbox <= 1'b0;
			char2_stunbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs2_x > 0 && abs2_x <= 64))
				char2_hurtbox <= 1'b1;
			else if((abs_y > 180 && abs_y <= 240) && (abs2_x > -44 && abs2_x <= 0))	
				char2_hurtbox <= 1'b1;
			else
				char2_hurtbox <= 1'b0;
		end
		
		S_dir_attack_recovery:
		begin
			char2_hitbox <= 1'b0;
			char2_stunbox <= 1'b0;
			
			if((abs_y > 0 && abs_y <= 240) && (abs2_x > 0 && abs2_x <= 64))
				char2_hurtbox <= 1'b1;	
			else if((abs_y > 100 && abs_y <= 240) && (abs2_x > -26 && abs2_x <= 0))
				char2_hurtbox <= 1'b1;				
			else
				char2_hurtbox <= 1'b0;	
		end
		
	endcase
	
	
end

	
	
endmodule

