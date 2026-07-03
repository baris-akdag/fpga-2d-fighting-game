module render_menu(
	input clk,
	input[9:0] next_x,
	input[9:0] next_y,
	
	input[3:0] char_state,
	input[3:0] char2_state,
	
	output reg menu_pixel	
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
	
always @(posedge clk) //background of menu
	
begin  

	menu_pixel <= 1'b0;	
	
	if (char_state == S_startup) 
   begin
		// letter "m"
		if (next_y > 100 && next_y <= 140) begin // straight lines of "m"
			if ((next_x > 205 && next_x <= 213) || (next_x > 221 && next_x <= 227) || (next_x > 233 && next_x <= 239) || (next_x > 247 && next_x <= 255)) begin
			menu_pixel <= 1'b1;
			end
		end
		if (next_y > 100 && next_y <= 108) begin // above middle lines
			if ((next_x > 213 && next_x <= 221) || (next_x > 239 && next_x <= 247)) begin
			menu_pixel <= 1'b1;
			end
		end
		if (next_y > 132 && next_y <= 140) begin // bottom middle line
			if (next_x > 227 && next_x <= 236) begin
			menu_pixel <= 1'b1;
			end
		end	


		// letter "e"
		if (next_y > 100 && next_y <= 140) begin // straight lines of "e"
			if ((next_x > 265 && next_x <= 273)) begin
			menu_pixel <= 1'b1;
			end
		end
		if (next_y > 100 && next_y <= 124) begin 
			if (next_x > 307 && next_x <= 315)  begin
			menu_pixel <= 1'b1;
			end
		end
		if (next_x > 273 && next_x <= 307) begin // horizontal lines of "e"
			if ((next_y > 100 && next_y <= 108) || (next_y > 116 && next_y <= 124)) begin
			menu_pixel <= 1'b1;
			end
		end
		if (next_x > 273 && next_x <= 315) begin 
			if (next_y > 132 && next_y <= 140)  begin
			menu_pixel <= 1'b1;
			end
		end
		
		// letter "n"
		if (next_y > 100 && next_y <= 140) begin // straight lines of "n"
			if ((next_x > 325 && next_x <= 333) || (next_x > 367 && next_x <= 375)) begin
			menu_pixel <= 1'b1;
			end
		end
		if (next_x > 333 && next_x <= 367) begin // horizontal lines of "u"
			if (next_y > 100 && next_y <= 108)  begin
			menu_pixel <= 1'b1;
			end
		end
		
		// letter "u"
		if (next_y > 100 && next_y <= 140) begin // straight lines of "u"
			if ((next_x > 385 && next_x <= 393) || (next_x > 427 && next_x <= 435)) begin
			menu_pixel <= 1'b1;
			end
		end
		if (next_x > 393 && next_x <= 427) begin // horizontal lines of "u"
			if (next_y > 132 && next_y <= 140)  begin
			menu_pixel <= 1'b1;
			end
		end
	end
	
end
	
endmodule
	

