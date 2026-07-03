module render_end(
	input clk,
	input[9:0] next_x,
	input[9:0] next_y,
	
	input[3:0] char_state,
	input[3:0] char2_state,
	input[1:0] winner,
	
	output reg end_pixel	
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

always @(posedge clk) //background of end screen
	
begin  

	end_pixel <= 1'b0;	
	
	if (char_state == S_gameover) 
	begin
		// letter "g"
		if (next_y > 100 && next_y <= 130) begin // straight line of "g"
			if ((next_x > 240 && next_x <= 242)) begin
			end_pixel <= 1'b1;
			end
		end
		if (next_x > 240 && next_x <= 260) begin // horizontal line of "g"
			if ((next_y > 100 && next_y <= 102) || (next_y > 128 && next_y <= 130)) begin
			end_pixel <= 1'b1;
			end
		end
		if (next_y > 115 && next_y <= 130) begin  // straight line of "g"
			if ((next_x > 258 && next_x <= 260)) begin
			end_pixel <= 1'b1;
			end
		end
		
		// letter "a"
		if (next_y > 100 && next_y <= 130) begin // straight lines of "a"
			if ((next_x > 262 && next_x <= 264) || (next_x > 280 && next_x <= 282)) 
			end_pixel <= 1'b1;
			end
		if (next_x > 262 && next_x <= 282) begin // horizontal lines of "a"
			if ((next_y > 100 && next_y <= 102) || (next_y > 115 && next_y <= 117))
			end_pixel <= 1'b1;
		end
		
		// letter "m"
		if (next_y > 100 && next_y <= 130) begin // straight lines of "m"
			if ((next_x > 284 && next_x <= 286) || (next_x > 294 && next_x <= 296) || (next_x > 302 && next_x <= 304)) begin
			end_pixel <= 1'b1;
			end
		end
		if (next_x > 284 && next_x <= 304) begin // horizontal line of "m"
			if ((next_y > 100 && next_y <= 102)) begin
			end_pixel <= 1'b1;
			end
		end
	
		// letter "e"
		if (next_y > 100 && next_y <= 130) begin // straight line of "e"
			if ((next_x > 306 && next_x <= 308)) begin
			end_pixel <= 1'b1;
			end
		end
		if (next_x > 306 && next_x <= 326) begin // horizontal lines of "e"
			if ((next_y > 100 && next_y <= 102) || (next_y > 115 && next_y <= 117) || (next_y > 128 && next_y <= 130)) begin
			end_pixel <= 1'b1;
			end
		end
		
		
		// letter "o"
		if (next_y > 100 && next_y <= 130) begin // straight lines of "o"
			if ((next_x > 332 && next_x <= 334) || (next_x > 350 && next_x <= 352)) begin
			end_pixel <= 1'b1;
			end
		end
		if (next_x > 332 && next_x <= 352) begin // horizontal lines of "o"
			if ((next_y > 100 && next_y <= 102) || (next_y > 128  && next_y <= 130)) begin
			end_pixel <= 1'b1;
			end
		end
		
		// letter "v"
		if (next_y > 100 && next_y <= 130) begin // straight lines of "v"
			if ((next_x > 354 && next_x <= 356) || (next_x > 372  && next_x <= 374)) begin
			end_pixel <= 1'b1;
			end
		end
		if (next_x > 354 && next_x <= 374) begin // horizontal lines of "o"
			if ((next_y > 128 && next_y <= 130)) begin
			end_pixel <= 1'b1;
			end
		end
		
		// letter "e"
		if (next_y > 100 && next_y <= 130) begin // straight line of "e"
			if ((next_x > 376 && next_x <= 378)) begin
			end_pixel <= 1'b1;
			end
		end
		if (next_x > 376 && next_x <= 396) begin // horizontal lines of "e"
			if ((next_y > 100 && next_y <= 102) || (next_y > 115 && next_y <= 117) || (next_y > 128 && next_y <= 130)) begin
			end_pixel <= 1'b1;
			end
		end
		
		
		// letter "r"
		if (next_y > 100 && next_y <= 130) begin // straight line of "r"
			if ((next_x > 398 && next_x <= 400))
			end_pixel <= 1'b1;
		end
		if (next_x > 398 && next_x <= 418) begin // horizontal line of "r"
			if ((next_y > 100 && next_y <= 102)) 
			end_pixel <= 1'b1;
		end
		if (next_y > 100 && next_y <= 115) begin // straight line of "r"
			if ((next_x > 416 && next_x <= 418)) 
			end_pixel <= 1'b1;
		end
		
		case (winner)
			2'b10: 
			begin 
			// letter "p"
			if (next_y > 160 && next_y <= 190) begin // straight line of "p"
				if ((next_x > 240 && next_x <= 242)) 
				end_pixel <= 1'b1;
				end
			if (next_y > 160 && next_y <= 175) begin // straight line of "p"
				if ((next_x > 258 && next_x <= 260)) 
				end_pixel <= 1'b1;
				end
			if (next_x > 240 && next_x <= 260) begin // horizontal lines of "p"
				if ((next_y > 160 && next_y <= 162) || (next_y > 175 && next_y <= 177))
				end_pixel <= 1'b1;
			end

			// 1
			if (next_y > 160 && next_y <= 190) begin // straight line of "p"
				if ((next_x > 274 && next_x <= 276)) 
				end_pixel <= 1'b1;
			end
			
			// letter "w"
			if (next_y > 160 && next_y <= 190) begin // straight line of "w"
				if ((next_x > 290 && next_x <= 292)) 
				end_pixel <= 1'b1;
			end
			if (next_y > 160 && next_y <= 190) begin // straight line of "w"
				if ((next_x > 300 && next_x <= 302)) 
				end_pixel <= 1'b1;
			end
			if (next_y > 160 && next_y <= 190) begin // straight line of "w"
				if ((next_x > 308 && next_x <= 310)) 
				end_pixel <= 1'b1;
			end
			if (next_x > 290 && next_x <= 310) begin // horizontal line of "w"
				if ((next_y > 188 && next_y <= 190))
				end_pixel <= 1'b1;
			end	
			// letter "o"
			if (next_y > 160 && next_y <= 190) begin // straight lines of "o"
				if ((next_x > 312 && next_x <= 314) || (next_x > 330 && next_x <= 332)) begin
				end_pixel <= 1'b1;
				end
			end
			if (next_x > 312 && next_x <= 332) begin // horizontal lines of "o"
				if ((next_y > 160 && next_y <= 162) || (next_y > 188  && next_y <= 190)) begin
				end_pixel <= 1'b1;
				end
			end
			
			// letter "n"
			if (next_y > 160 && next_y <= 190) begin // straight lines of "n"
				if ((next_x > 334 && next_x <= 336) || (next_x > 352 && next_x <= 354)) begin
				end_pixel <= 1'b1;
				end
			end
			if (next_x > 334 && next_x <= 354) begin // horizontal line of "n"
				if ((next_y > 160 && next_y <= 162)) 
				end_pixel <= 1'b1;
			end
			
			end//case end
			2'b01: 
			begin 
			// letter "p"
			if (next_y > 160 && next_y <= 190) begin // straight line of "p"
				if ((next_x > 240 && next_x <= 242)) 
				end_pixel <= 1'b1;
				end
			if (next_y > 160 && next_y <= 175) begin // straight line of "p"
				if ((next_x > 258 && next_x <= 260)) 
				end_pixel <= 1'b1;
				end
			if (next_x > 240 && next_x <= 260) begin // horizontal lines of "p"
				if ((next_y > 160 && next_y <= 162) || (next_y > 175 && next_y <= 177))
				end_pixel <= 1'b1;
			end

			// 2
			if (next_y > 175 && next_y <= 190) begin 
				if ((next_x > 262 && next_x <= 264)) 
				end_pixel <= 1'b1;
				end
			if (next_y > 160 && next_y <= 175) begin 
				if ((next_x > 280 && next_x <= 282)) 
				end_pixel <= 1'b1;
				end
			if (next_x > 262 && next_x <= 282) begin // horizontal lines of "2"
				if ((next_y > 160 && next_y <= 162) || (next_y > 175 && next_y <= 177) || (next_y > 188 && next_y <= 190))
				end_pixel <= 1'b1;
			end
			
			// letter "w"
			if (next_y > 160 && next_y <= 190) begin // straight line of "w"
				if ((next_x > 290 && next_x <= 292)) 
				end_pixel <= 1'b1;
			end
			if (next_y > 160 && next_y <= 190) begin // straight line of "w"
				if ((next_x > 300 && next_x <= 302)) 
				end_pixel <= 1'b1;
			end
			if (next_y > 160 && next_y <= 190) begin // straight line of "w"
				if ((next_x > 308 && next_x <= 310)) 
				end_pixel <= 1'b1;
			end
			if (next_x > 290 && next_x <= 310) begin // horizontal line of "w"
				if ((next_y > 188 && next_y <= 190))
				end_pixel <= 1'b1;
			end	
			// letter "o"
			if (next_y > 160 && next_y <= 190) begin // straight lines of "o"
				if ((next_x > 312 && next_x <= 314) || (next_x > 330 && next_x <= 332)) begin
				end_pixel <= 1'b1;
				end
			end
			if (next_x > 312 && next_x <= 332) begin // horizontal lines of "o"
				if ((next_y > 160 && next_y <= 162) || (next_y > 188  && next_y <= 190)) begin
				end_pixel <= 1'b1;
				end
			end
			
			// letter "n"
			if (next_y > 160 && next_y <= 190) begin // straight lines of "n"
				if ((next_x > 334 && next_x <= 336) || (next_x > 352 && next_x <= 354)) begin
				end_pixel <= 1'b1;
				end
			end
			if (next_x > 334 && next_x <= 354) begin // horizontal line of "n"
				if ((next_y > 160 && next_y <= 162)) 
				end_pixel <= 1'b1;
				end
				
			end // case end
			
			2'b00: 
			begin
			// letter "e"
			if (next_y > 160 && next_y <= 190) begin // straight line of "e"
				if ((next_x > 240 && next_x <= 242)) begin
				end_pixel <= 1'b1;
				end
			end
			if (next_x > 240 && next_x <= 260) begin // horizontal lines of "e"
				if ((next_y > 160 && next_y <= 162) || (next_y > 175 && next_y <= 177) || (next_y > 188 && next_y <= 190)) begin
				end_pixel <= 1'b1;
				end
			end

			// letter "q"
			if (next_y > 160 && next_y <= 190) begin // straight lines of "q"
				if ((next_x > 262 && next_x <= 264) || (next_x > 280 && next_x <= 282)) begin
				end_pixel <= 1'b1;
				end
			end
			if (next_x > 262 && next_x <= 282) begin // horizontal lines of "o"
				if ((next_y > 160 && next_y <= 162)) begin
				end_pixel <= 1'b1;
				end
			end
			if (next_x > 262 && next_x <= 287) begin // horizontal lines of "o"
				if ((next_y > 188  && next_y <= 190)) begin
				end_pixel <= 1'b1;
				end
			end
			
			end // case end
		endcase

	end//if end
	
end//always end
	
endmodule
	
	