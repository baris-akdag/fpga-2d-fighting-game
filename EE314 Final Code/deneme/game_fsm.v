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
	output reg[3:0] char2_state
);

reg[3:0] state = 4'b0000;
reg[3:0] state2 = 4'b0000;
reg[1:0] counter_control = 2'b00;
reg[1:0] counter2_control = 2'b00;
reg[1:0] timer_control = 2'b00;
wire[7:0] count, count2, timer;

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

Counter #(.W(8)) fight_time_counter
(
.clk(clk),
.control(timer_control),
.count(timer)
);

reg initialize = 1'b0;
reg timer_initalize = 1'b0;

always@(posedge clk)
begin

	if (initialize == 0)
	begin
		char_x <= 10'd100;
		char2_x <= 10'd476;
		state <= S_startup;
		state2 <= S_startup;
		initialize <= 1'b1;
	end
	
	else
	begin
		case(state)
			
			S_startup: //Work in progress
			begin
				if (attack == 1) state <= S_idle;
				timer_control <= reset;
			end
			
			S_gameover: //Work in progress
			begin
				
				timer_control <= hold;
			end
			
			S_idle:
			begin
				//state transitions based on inputs
				if (right == 1 && left != 1) state <= S_right;
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
				if(attack == 1) state <= S_dir_attack_start;
				else if (right == 1 && left != 1) state <= S_right;
				else if (right != 1 && left == 1) state <= S_left;		
				else state <= S_idle;
				
				//outputs based on the state and inputs
				if (char_x > 573) char_x <= char_x;	//Out of bounds detection
				
				else if(char_x + 70 > char2_x) char_x <= char_x;
				
				else char_x <= char_x + 2'b11;
				
				char_state <= state;
			end
			
			S_left:
			begin
				//state transitions based on inputs
				if(attack == 1) state <= S_dir_attack_start;
				else if (right == 1 && left != 1) state <= S_right;
				else if (right != 1 && left == 1) state <= S_left;
				else state <= S_idle;
				
				//outputs based on the state and inputs
				if (char_x < 3) char_x <= char_x;//Out of bounds detection
				else char_x <= char_x - 2'b10;
				
				char_state <= state;
			end
			
			S_attack_start:
			begin
				//frame counter that after a certain frames goes to the next attack state
				counter_control <= increment;
				state <= S_attack_start;
				
				if (count == 2)
				begin
					counter_control <= reset;
					state<= S_attack_active;
				end
				
				char_x <= char_x;
				char_state <= state;
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
			end
			
			S_attack_recovery:
			begin	
				//frame counter that after a certain frames goes to the next attack state
				counter_control <= increment;
				state <= S_attack_recovery;
				
				if (count == 14)
				begin
					counter_control <= reset;
					state<= S_idle;
				end
				
				char_x <= char_x;
				char_state <= state;
			end
			
			S_dir_attack_start:
			begin	
				//frame counter that after a certain frames goes to the next attack state
				counter_control <= increment;
				state <= S_dir_attack_start;
				
				if (count == 1)
				begin
					counter_control <= reset;
					state<= S_dir_attack_active;
				end
				
				char_x <= char_x;
				char_state <= state;
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
			end
			
			S_dir_attack_recovery:
			begin
				//frame counter that after a certain frames goes to the next attack state
				counter_control <= increment;
				state <= S_dir_attack_recovery;
				
				if (count == 13)
				begin
					counter_control <= reset;
					state<= S_idle;
				end
				
				char_x <= char_x;
				char_state <= state;
			end
		
		endcase
		
		case(state2)
			
			S_startup: //Work in progress
			begin
				if (attack == 1) state2 <= S_idle;
				
			end
			
			S_gameover: //Work in progress
			begin
				
			end
			
			S_idle:
			begin
				//state transitions based on inputs
				if (right2 == 1 && left2 != 1) state2 <= S_right;
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
				if(attack2 == 1) state2 <= S_dir_attack_start;
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
				if(attack2 == 1) state2 <= S_dir_attack_start;
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
				counter2_control <= increment;
				state2 <= S_attack_start;
				
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
				//frame counter that after a certain frames goes to the next attack state
				counter2_control <= increment;
				state2 <= S_attack_recovery;
				
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
				//frame counter that after a certain frames goes to the next attack state
				counter2_control <= increment;
				state2 <= S_dir_attack_start;
				
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
				//frame counter that after a certain frames goes to the next attack state
				counter2_control <= increment;
				state2 <= S_dir_attack_recovery;
				
				if (count2 == 13)
				begin
					counter2_control <= reset;
					state2 <= S_idle;
				end
				
				char2_x <= char2_x;
				char2_state <= state2;
			end
		
		endcase
		
	end //initialize end	
end //always @(posedge clk) end






endmodule