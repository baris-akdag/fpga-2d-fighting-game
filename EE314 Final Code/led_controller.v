module led_controller
(
	input clk,
	input[3:0] char_state,
	input[3:0] char2_state,
	input[1:0] char_hp,
	input[1:0] char2_hp,
	input[1:0] char_bp,
	input[1:0] char2_bp,
	output reg[9:0] led
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

clock_divider oneHz2
(
.clk(clk),
.division_factor(7),
.modded_clk(blink_clk)
);
reg initialize = 1'b0 ;

always@(posedge blink_clk)
begin
	case(char_state)
	
		S_startup, S_countdown:
		begin
			led <= 10'b0000_0000_00;
			initialize <= 0;
		end
		
		S_gameover:
		begin
			if (initialize == 0) 
			begin
			led <= 10'b0000_0000_00;
			initialize <= 1;
			end
			else led <= ~led ;	
		end
		
		default:
		begin
			case(char_hp)
				2'b00: led[2:0] <= 3'b111;
				2'b01: led[2:0] <= 3'b011;
				2'b10: led[2:0] <= 3'b001;
				2'b11: led[2:0] <= 3'b000;
			endcase

			case(char2_hp)
				2'b00: led[9:7] <= 3'b111;
				2'b01: led[9:7] <= 3'b011;
				2'b10: led[9:7] <= 3'b001;
				2'b11: led[9:7] <= 3'b000;
			endcase	
		end
	endcase
end

endmodule