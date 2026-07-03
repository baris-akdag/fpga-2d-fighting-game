module gameplay_cd(
	input clk,
	input[9:0] next_x,
	input[9:0] next_y,
	

	input[7:0] timer,
	input[3:0] char_state,
	input[3:0] char2_state,
	
	output reg cd_pixel
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

reg[3:0] tens, units;

reg signed [9:0] unit_x = 10'd_321; 
reg signed [9:0] unit_y = 10'd_80; 

reg signed [9:0] tens_x = 10'd_314; 
reg signed [9:0] tens_y = 10'd_80; 

reg signed [9:0] abs_unit_x;
reg signed [9:0] abs_unit_y;

reg signed [9:0] abs_tens_x;
reg signed [9:0] abs_tens_y;


always@(*)
begin	
	case(timer)

	  8'd90, 8'd91, 8'd92, 8'd93, 8'd94, 8'd95, 8'd96, 8'd97, 8'd98, 8'd99: 
			begin tens = 4'd9; units = timer - 8'd90; end
			
	  8'd80, 8'd81, 8'd82, 8'd83, 8'd84, 8'd85, 8'd86, 8'd87, 8'd88, 8'd89: 
			begin tens = 4'd8; units = timer - 8'd80; end
			
	  8'd70, 8'd71, 8'd72, 8'd73, 8'd74, 8'd75, 8'd76, 8'd77, 8'd78, 8'd79: 
			begin tens = 4'd7; units = timer - 8'd70; end
			
	  8'd60, 8'd61, 8'd62, 8'd63, 8'd64, 8'd65, 8'd66, 8'd67, 8'd68, 8'd69: 
			begin tens = 4'd6; units = timer - 8'd60; end
			
	  8'd50, 8'd51, 8'd52, 8'd53, 8'd54, 8'd55, 8'd56, 8'd57, 8'd58, 8'd59: 
			begin tens = 4'd5; units = timer - 8'd50; end
			
	  8'd40, 8'd41, 8'd42, 8'd43, 8'd44, 8'd45, 8'd46, 8'd47, 8'd48, 8'd49: 
			begin tens = 4'd4; units = timer - 8'd40; end
			
	  8'd30, 8'd31, 8'd32, 8'd33, 8'd34, 8'd35, 8'd36, 8'd37, 8'd38, 8'd39: 
			begin tens = 4'd3; units = timer - 8'd30; end
			
	  8'd20, 8'd21, 8'd22, 8'd23, 8'd24, 8'd25, 8'd26, 8'd27, 8'd28, 8'd29: 
			begin tens = 4'd2; units = timer - 8'd20; end
			
	  8'd10, 8'd11, 8'd12, 8'd13, 8'd14, 8'd15, 8'd16, 8'd17, 8'd18, 8'd19: 
			begin tens = 4'd1; units = timer - 8'd10; end
			
     8'd0, 8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6, 8'd7, 8'd8, 8'd9: 
			begin tens = 4'd0; units = timer; end
		default: 
			begin tens = 4'd0; units = 0; end // 0-9
	endcase
end

always @(posedge clk) 
begin

	abs_unit_x <= next_x - unit_x;
	abs_unit_y <= next_y - unit_y;
	
	abs_tens_x <= next_x - tens_x;
	abs_tens_y <= next_y - tens_y;
	
	cd_pixel <= 1'b0;
	
	case(char_state)
	S_startup, S_countdown:
	begin
		cd_pixel <= 1'b0;
	end
	
	default:
	begin
		case (units)
		
		8'd0: begin
			if (abs_unit_x >= 0  && abs_unit_x <= 5 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y < 2) || (abs_unit_y >= 8 && abs_unit_y < 10 ))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_y >= 0  && abs_unit_y < 10 ) begin
				if ((abs_unit_x >= 0  && abs_unit_x < 2) || (abs_unit_x >= 4 && abs_unit_x < 6 ))
					cd_pixel <= 1'b1;
			end
		end

		8'd1: begin
			if (abs_unit_x >= 4  && abs_unit_x < 6 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
		end

		8'd2: begin
			if (abs_unit_x >= 0  && abs_unit_x <  6 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y <  2) || (abs_unit_y >= 4 && abs_unit_y < 6) || (abs_unit_y >= 8 && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 4  && abs_unit_x < 6 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y < 5))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 0  && abs_unit_x < 2 ) begin
				if ((abs_unit_y >= 5 && abs_unit_y < 9))
					cd_pixel <= 1'b1;
			end
		end

		8'd3: begin 
			if (abs_unit_x >= 0 && abs_unit_x <= 5) begin
				if ((abs_unit_y >= 0 && abs_unit_y < 2) || (abs_unit_y >= 4 && abs_unit_y < 6) || (abs_unit_y >= 8 && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 4 && abs_unit_x < 6) begin 
				if ((abs_unit_y >= 0 && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
		end


		8'd4: begin 
			if (abs_unit_x >= 0 && abs_unit_x < 2) begin
				if ((abs_unit_y >= 0 && abs_unit_y < 5))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 4 && abs_unit_x < 6) begin 
				if ((abs_unit_y >= 0 && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 0 && abs_unit_x <= 5) begin 
				if ((abs_unit_y >= 4 && abs_unit_y < 6))
					cd_pixel <= 1'b1;
			end
		end

		8'd5: begin
			if (abs_unit_x >= 0  && abs_unit_x <= 5 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y < 2) || (abs_unit_y >= 4 && abs_unit_y < 6) || (abs_unit_y >= 8 && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 4  && abs_unit_x < 6 ) begin
				if ((abs_unit_y >= 5  && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 0  && abs_unit_x < 2 ) begin
				if ((abs_unit_y >= 0 && abs_unit_y <= 4))
					cd_pixel <= 1'b1;
			end
		end

		8'd6: begin
			if (abs_unit_x >= 0  && abs_unit_x <= 5 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y < 2) || (abs_unit_y >= 4 && abs_unit_y < 6) || (abs_unit_y >= 8 && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 4  && abs_unit_x < 6 ) begin // straight line of 6
				if ((abs_unit_y >= 5  && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 0  && abs_unit_x < 2 ) begin
				if ((abs_unit_y >= 0 && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
		end

		8'd7: begin
			if (abs_unit_x >= 4  && abs_unit_x < 6 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 0  && abs_unit_x <= 5 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y < 2))
					cd_pixel <= 1'b1;
			end
		end

		8'd8: begin
			if (abs_unit_x >= 0  && abs_unit_x <= 5 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y <= 2) || (abs_unit_y >= 4 && abs_unit_y < 6) || (abs_unit_y >= 8 && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 4  && abs_unit_x < 6 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 0  && abs_unit_x < 2 ) begin
				if ((abs_unit_y >= 0 && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
		end

		8'd9: begin
			if (abs_unit_x >= 0  && abs_unit_x <= 5 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y < 2) || (abs_unit_y >= 4 && abs_unit_y < 6) || (abs_unit_y >= 8 && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 4  && abs_unit_x < 6 ) begin
				if ((abs_unit_y >= 0  && abs_unit_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_unit_x >= 0  && abs_unit_x < 2 ) begin
				if ((abs_unit_y >= 0 && abs_unit_y <= 4))
					cd_pixel <= 1'b1;
			end
		end
		endcase
		
		
	
		case (tens)
		
		8'd0: begin
			if (abs_tens_x >= 0  && abs_tens_x <= 5 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y < 2) || (abs_tens_y >= 8 && abs_tens_y < 10 ))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_y >= 0  && abs_tens_y < 10 ) begin
				if ((abs_tens_x >= 0  && abs_tens_x < 2) || (abs_tens_x >= 4 && abs_tens_x < 6 ))
					cd_pixel <= 1'b1;
			end
		end

		8'd1: begin
			if (abs_tens_x >= 4  && abs_tens_x < 6 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
		end

		8'd2: begin
			if (abs_tens_x >= 0  && abs_tens_x <  6 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y <  2) || (abs_tens_y >= 4 && abs_tens_y < 6) || (abs_tens_y >= 8 && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 4  && abs_tens_x < 6 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y < 5))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 0  && abs_tens_x < 2 ) begin
				if ((abs_tens_y >= 5 && abs_tens_y < 9))
					cd_pixel <= 1'b1;
			end
		end

		8'd3: begin 
			if (abs_tens_x >= 0 && abs_tens_x <= 5) begin
				if ((abs_tens_y >= 0 && abs_tens_y < 2) || (abs_tens_y >= 4 && abs_tens_y < 6) || (abs_tens_y >= 8 && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 4 && abs_tens_x < 6) begin 
				if ((abs_tens_y >= 0 && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
		end


		8'd4: begin 
			if (abs_tens_x >= 0 && abs_tens_x < 2) begin
				if ((abs_tens_y >= 0 && abs_tens_y < 5))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 4 && abs_tens_x < 6) begin 
				if ((abs_tens_y >= 0 && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 0 && abs_tens_x <= 6) begin 
				if ((abs_tens_y >= 4 && abs_tens_y < 6))
					cd_pixel <= 1'b1;
			end
		end

		8'd5: begin
			if (abs_tens_x >= 0  && abs_tens_x <= 5 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y < 2) || (abs_tens_y >= 4 && abs_tens_y < 6) || (abs_tens_y >= 8 && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 4  && abs_tens_x< 6 ) begin
				if ((abs_tens_y >= 5  && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 0  && abs_tens_x < 2 ) begin
				if ((abs_tens_y >= 0 && abs_tens_y <= 4))
					cd_pixel <= 1'b1;
			end
		end

		8'd6: begin
			if (abs_tens_x >= 0  && abs_tens_x <= 5 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y < 2) || (abs_tens_y >= 4 && abs_tens_y < 6) || (abs_tens_y >= 8 && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 4  && abs_tens_x < 6 ) begin // straight line of 6
				if ((abs_tens_y >= 5  && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 0  && abs_tens_x < 2 ) begin
				if ((abs_tens_y >= 0 && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
		end

		8'd7: begin
			if (abs_tens_x >= 4  && abs_tens_x < 6 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 0  && abs_tens_x <= 5 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y < 2))
					cd_pixel <= 1'b1;
			end
		end

		8'd8: begin
			if (abs_tens_x >= 0  && abs_tens_x <= 5 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y <= 2) || (abs_tens_y >= 4 && abs_tens_y < 6) || (abs_tens_y >= 8 && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 4  && abs_tens_x < 6 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 0  && abs_tens_x < 2 ) begin
				if ((abs_tens_y >= 0 && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
		end

		8'd9: begin
			if (abs_tens_x >= 0  && abs_tens_x <= 5 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y < 2) || (abs_tens_y >= 4 && abs_tens_y < 6) || (abs_tens_y >= 8 && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 4  && abs_tens_x < 6 ) begin
				if ((abs_tens_y >= 0  && abs_tens_y < 10))
					cd_pixel <= 1'b1;
			end
			if (abs_tens_x >= 0  && abs_tens_x < 2 ) begin
				if ((abs_tens_y >= 0 && abs_tens_y <= 4))
					cd_pixel <= 1'b1;
			end
		end
		endcase

	end
	endcase
end


endmodule