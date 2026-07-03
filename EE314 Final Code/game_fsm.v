module game_fsm
(
	input clk,
	
	input right,
	input left,
	input attack,
	
	input right2,
	input left2,
	input attack2,

	output reg[9:0] char_x,
	output reg[9:0] char2_x,
	
	output reg[3:0] char_state,
	output reg[3:0] char2_state,
	
	output reg hitdetect,
	output reg hitdetect2,
	
	output reg[1:0] char_hp,
	output reg[1:0] char2_hp,
	output reg[1:0] char_bp,
	output reg[1:0] char2_bp,
	output reg[1:0] cd,
	
	output[7:0] timer
);

reg[3:0] state = 4'b0000;
reg[3:0] state2 = 4'b0000;

reg[1:0] counter_control = 2'b00;
reg[1:0] counter2_control = 2'b00;

reg[1:0] timer_control = 2'b00;
reg set_game_over = 1'b0;


wire[7:0] count, count2;
wire timer_clk;

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

localparam hold = 2'b00;
localparam increment = 2'b01;
localparam decrement = 2'b10;
localparam reset = 2'b11;

Counter #(.W(8)) frame_counter
(
.clk(clk),
.control(counter_control),
.count(count)
);

Counter #(.W(8)) frame_counter2
(
.clk(clk),
.control(counter2_control),
.count(count2)
);

clock_divider oneHz
(
.clk(clk),
.division_factor(13),
.modded_clk(timer_clk)
);

Counter #(.W(8)) fight_time_counter
(
.clk(timer_clk),
.control(timer_control),
.count(timer)
);

reg initialize = 1'b0;
reg timer_initalize = 1'b0;
//reg eq_initialize = 1'b0;

always@(posedge clk)
begin

	if (initialize == 0)
	begin
		
		
		state <= S_startup;
		state2 <= S_startup;
		cd <= 0;
		initialize <= 1'b1;
	end
	
	//hit detection
	if (state == S_attack_active) 
	begin
		if((char2_x - char_x) <= 128)
		begin
			hitdetect2 <= 1'b1;
		end	
	end
	
	else if (state == S_dir_attack_active)
	begin
		if((char2_x - char_x) <= 104)
		begin
			hitdetect2 <= 1'b1;
		end	
	end
	
	else hitdetect2 <= 1'b0;
	
	
	if (state2 == S_attack_active)
	begin
		if((char2_x - char_x) <= 128)
		begin
			hitdetect <= 1'b1;
		end
	end
	
	else if (state2 == S_dir_attack_active)
	begin
		if((char2_x - char_x) <= 104)
		begin
			hitdetect <= 1'b1;
		end
	end
	
	else hitdetect <= 1'b0;
	
	
	begin
		case(state)
			
			S_startup: //Work in progress
			begin
				char_x <= 10'd100;
				char2_x <= 10'd476;
		
				char_hp <= 2'b00;
				char2_hp <= 2'b00;
				char_bp <= 2'b00;
				char2_bp <= 2'b00;
				
				counter_control <= reset;
				cd <= 1'b0;
				set_game_over <= 1'b0;
				
				state <= S_startup;
				if (attack == 1) state <= S_countdown;
				timer_control <= reset;
				//eq_initialize <= 1'b0;
				
				char_state <= state;
			end
			
			S_countdown:
			begin
				counter_control <= increment;
				state <= S_countdown;
				
				if (count == 27)
				begin
					cd <= cd + 1'b1;
					counter_control <= reset;
					
					if(cd == 3)	
					begin
						counter_control <= reset;
						state<= S_idle;
					end
				end
				
				char_state <= state;
			end
			
			S_gameover: //Work in progress
			begin
//				state <= S_gameover;
//				state2 <= S_gameover;
				
				timer_control <= hold;
				
				if((attack) || (right) || (left))
				begin
					state <= S_startup;
					state2 <= S_startup;
					set_game_over <= 1'b0;
				end
				
				char2_state <= state2;
				char_state <= state;
			end
			
			S_idle:
			begin
				//state transitions based on inputs
				if (hitdetect) state <= S_hitstun;
				else if (right == 1 && left != 1) state <= S_right;
				else if (right != 1 && left == 1) state <= S_left;
				else if(attack == 1) state <= S_attack_start;
				else state <= S_idle;
				
				//when the fight first starts start incrementing the timer
				timer_control <= increment;
				
				//outputs based on the state and inputs
				char_x <= char_x;
				char_state <= state;
			end
			
			S_right:
			begin
				//state transitions based on inputs
				if (hitdetect) state <= S_hitstun;
				else if(attack == 1) state <= S_dir_attack_start;
				else if (right == 1 && left != 1) state <= S_right;
				else if (right != 1 && left == 1) state <= S_left;		
				else state <= S_idle;
				
				//outputs based on the state and inputs
				if (char_x > 573) char_x <= char_x;	//Out of bounds detection
				
				else if(char_x + 70 > char2_x) char_x <= char_x;
				
				else char_x <= char_x + 2'b11;
				
				timer_control <= increment;
				char_state <= state;
			end
			
			S_left:
			begin
				//state transitions based on inputs
				if (hitdetect)
				begin
					if(char_bp < 2'b11) state <= S_blockstun;
					else state <= S_hitstun;	
				end
				else if(attack == 1) state <= S_dir_attack_start;
				else if (right == 1 && left != 1) state <= S_right;
				else if (right != 1 && left == 1) state <= S_left;
				else state <= S_idle;
				
				//outputs based on the state and inputs
				if (char_x < 3) char_x <= char_x;//Out of bounds detection
				else char_x <= char_x - 2'b10;
				
				timer_control <= increment;
				char_state <= state;
			end
			
			S_attack_start:
			begin
				
				if (hitdetect) state <= S_hitstun;
				
				//frame counter that after a certain frames goes to the next attack state
				else
				begin
				counter_control <= increment;
				state <= S_attack_start;
				end
				
				if (count == 2)
				begin
					counter_control <= reset;
					state<= S_attack_active;
				end
				
				char_x <= char_x;
				char_state <= state;
				timer_control <= increment;
			end
			
			S_attack_active:
			begin		
				//frame counter that after a certain frames goes to the next attack state
				counter_control <= increment;
				state <= S_attack_active;
				
				if (count == 0)
				begin
					counter_control <= reset;
					state <= S_attack_recovery;
				end
				
				char_x <= char_x;
				char_state <= state;
				timer_control <= increment;
			end
			
			S_attack_recovery:
			begin	
				if (hitdetect) state <= S_hitstun;
				
				//frame counter that after a certain frames goes to the next attack state
				else
				begin
				counter_control <= increment;
				state <= S_attack_recovery;
				end
				
				if (count == 14)
				begin
					counter_control <= reset;
					state<= S_idle;
				end
				
				char_x <= char_x;
				char_state <= state;
				timer_control <= increment;
			end
			
			S_dir_attack_start:
			begin	
				if (hitdetect) state <= S_hitstun;
				
				//frame counter that after a certain frames goes to the next attack state
				else
				begin
				counter_control <= increment;
				state <= S_dir_attack_start;
				end
				
				if (count == 1)
				begin
					counter_control <= reset;
					state<= S_dir_attack_active;
				end
				
				char_x <= char_x;
				char_state <= state;
				timer_control <= increment;
			end
			
			S_dir_attack_active:
			begin
				
				//frame counter that after a certain frames goes to the next attack state	
				counter_control <= increment;
				state <= S_dir_attack_active;

				if (count == 1)
				begin
					counter_control <= reset;
					state<= S_dir_attack_recovery;
				end
				
				char_x <= char_x;
				char_state <= state;
				timer_control <= increment;
			end
			
			S_dir_attack_recovery:
			begin
				if (hitdetect) state <= S_hitstun;
				
				//frame counter that after a certain frames goes to the next attack state
				else
				begin
				counter_control <= increment;
				state <= S_dir_attack_recovery;
				end
				
				if (count == 13)
				begin
					counter_control <= reset;
					state<= S_idle;
				end
				
				char_x <= char_x;
				char_state <= state;
				timer_control <= increment;
			end
			
			S_hitstun:
			begin
				counter_control <= increment;
				state	<= S_hitstun;
				
				if (count == 13)
				begin
					counter_control <= reset;
					state <= S_idle;
					
					char_hp <= char_hp + 1'b1;
					if (char_hp == 2'b10)
					begin
						set_game_over <= 1'b1;
					end
				end
				
				char_x <= char_x;
				char_state <= state;
				char2_state <= state2;
				timer_control <= increment;
			end
			
			S_blockstun:
			begin
				counter_control <= increment;
				state	<= S_blockstun;
				
				
				if (count == 11)
				begin
					char_bp <= char_bp + 1'b1;
					counter_control <= reset;
					state <= S_idle;
				end
				
				char_x <= char_x;
				char_state <= state;
				timer_control <= increment;
			end
			
		endcase
		
		//
		//
		//
		// 2nd character
		//
		//
		//
		
		case(state2)
			
			S_startup: //Work in progress
			begin
				char_x <= 10'd100;
				char2_x <= 10'd476;
		
				char_hp <= 2'b00;
				char2_hp <= 2'b00;
				char_bp <= 2'b00;
				char2_bp <= 2'b00;
				
				counter_control <= reset;
				cd <= 1'b0;
				set_game_over <= 1'b0;
				
				state <= S_startup;
				if (attack == 1) state2 <= S_countdown;
				char2_state <= state2;
			end
			
			S_countdown:
			begin
				counter_control <= increment;
				state2 <= S_countdown;
				
				if (count == 27)
				begin
					cd <= cd + 1'b1;
					counter_control <= reset;
					if(cd == 3)
					begin
						counter_control <= reset;
						state2 <= S_idle;
					end
				end
				
				char2_state <= state2;
			end
			
			S_gameover: //Work in progress
			begin
//				state <= S_gameover;
//				state2 <= S_gameover;
				
				if((attack) || (right) || (left))
				begin
					state <= S_startup;
					state2 <= S_startup;
					set_game_over <= 1'b0;
				end
				
				char2_state <= state2;
				char_state <= state;
			end
			
			S_idle:
			begin
				//state transitions based on inputs
				if (hitdetect2) state2 <= S_hitstun;
				else if (right2 == 1 && left2 != 1) state2 <= S_right;
				else if (right2 != 1 && left2 == 1) state2 <= S_left;
				else if(attack2 == 1) state2 <= S_attack_start;
				else state2 <= S_idle;
				
				
				//outputs based on the state and inputs
				char2_x <= char2_x;
				char2_state <= state2;
			end
			
			S_right:
			begin
				//state transitions based on inputs
				if (hitdetect2)
				begin
					if(char2_bp < 2'b11) state2 <= S_blockstun;
					else state2 <= S_hitstun;	
				end
				else if(attack2 == 1) state2 <= S_dir_attack_start;
				else if (right2 == 1 && left2 != 1) state2 <= S_right;
				else if (right2 != 1 && left2 == 1) state2 <= S_left;		
				else state2 <= S_idle;
				
				//outputs based on the state and inputs
				if (char2_x > 573) char2_x <= char2_x; //Out of bounds detection
				else char2_x <= char2_x + 2'b10;
				
				char2_state <= state2;
			end
			
			S_left:
			begin
				//state transitions based on inputs
				if (hitdetect2) state2 <= S_hitstun;
				else if(attack2 == 1) state2 <= S_dir_attack_start;
				else if (right2 == 1 && left2 != 1) state2 <= S_right;
				else if (right2 != 1 && left2 == 1) state2 <= S_left;
				else state2 <= S_idle;
				
				//outputs based on the state and inputs
				if (char2_x < 3) char2_x <= char2_x;//Out of bounds detection
				else if(char2_x < char_x + 70 ) char2_x <= char2_x;
				else char2_x <= char2_x - 2'b11;
				
				char2_state <= state2;
			end
			
			S_attack_start:
			begin
				//frame counter that after a certain frames goes to the next attack state
				if (hitdetect2) state2 <= S_hitstun;
				else
				begin
				counter2_control <= increment;
				state2 <= S_attack_start;
				end
				
				if (count2 == 2)
				begin
					counter2_control <= reset;
					state2 <= S_attack_active;
				end
				
				char2_x <= char2_x;
				char2_state <= state2;
			end
			
			S_attack_active:
			begin		
				//frame counter that after a certain frames goes to the next attack state
				counter2_control <= increment;
				state2 <= S_attack_active;
				
				if (count2 == 0)
				begin
					counter2_control <= reset;
					state2 <= S_attack_recovery;
				end
				
				char2_x <= char2_x;
				char2_state <= state2;
			end
			
			S_attack_recovery:
			begin	
				if (hitdetect2) state2 <= S_hitstun;
				//frame counter that after a certain frames goes to the next attack state
				else
				begin
				counter2_control <= increment;
				state2 <= S_attack_recovery;
				end
				
				if (count2 == 14)
				begin
					counter2_control <= reset;
					state2 <= S_idle;
				end
				
				char2_x <= char2_x;
				char2_state <= state2;
			end
			
			S_dir_attack_start:
			begin	
				if (hitdetect2) state2 <= S_hitstun;
				//frame counter that after a certain frames goes to the next attack state
				else
				begin
				counter2_control <= increment;
				state2 <= S_dir_attack_start;
				end
				
				if (count2 == 1)
				begin
					counter2_control <= reset;
					state2 <= S_dir_attack_active;
				end
				
				char2_x <= char2_x;
				char2_state <= state2;
			end
			
			S_dir_attack_active:
			begin
				//frame counter that after a certain frames goes to the next attack state
				counter2_control <= increment;
				state2 <= S_dir_attack_active;
				
				if (count2 == 1)
				begin
					counter2_control <= reset;
					state2 <= S_dir_attack_recovery;
				end
				
				char2_x <= char2_x;
				char2_state <= state2;
			end
			
			S_dir_attack_recovery:
			begin
				if (hitdetect2) state2 <= S_hitstun;
				
				//frame counter that after a certain frames goes to the next attack state
				else
				begin
				counter2_control <= increment;
				state2 <= S_dir_attack_recovery;
				end
				
				if (count2 == 13)
				begin
					counter2_control <= reset;
					state2 <= S_idle;
				end
				
				char2_x <= char2_x;
				char2_state <= state2;
			end
			
			S_hitstun:
			begin
				counter2_control <= increment;
				state2 <= S_hitstun;
	
				if (count2 == 13)
				begin
					counter2_control <= reset;
					state2 <= S_idle;
					
					char2_hp <= char2_hp + 1'b1;
					
					if (char2_hp == 2'b10)
					begin
						set_game_over <= 1'b1;
					end
				end
				char2_x <= char2_x;
				char2_state <= state2;
				char_state <= state;
			end
			
			S_blockstun:
			begin
				counter2_control <= increment;
				state2 <= S_blockstun;	
				
				if (count2 == 11)
				begin
					counter2_control <= reset;
					state2 <= S_idle;
					char2_bp <= char2_bp + 1'b1;
				end
				
				char2_x <= char2_x;
				char2_state <= state2;
			end
			
		endcase			
	end //initialize end	
	
	if (timer == 99)
	begin
		set_game_over <= 1;
//		eq_initialize <= 1;
		timer_control <= reset;
	end
	
	if (set_game_over) begin
		state <= S_gameover;
		state2 <= S_gameover;
	end
	
	
end //always @(posedge clk) end






endmodule