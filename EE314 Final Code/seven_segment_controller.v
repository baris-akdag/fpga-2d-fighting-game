module seven_segment_controller (
    input [3:0] game_state,      
    input sw,                   
    input [7:0] timer,    
    input [1:0] winner,        
    output reg [6:0] hex0,
    output reg [6:0] hex1,
    output reg [6:0] hex2,
    output reg [6:0] hex3,
    output reg [6:0] hex4,
    output reg [6:0] hex5
   );
	

reg[3:0] tens, units;
reg[6:0] hex_tens, hex_units;

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


  
     //     //6543210
     //   0 = 7'b1000000;
     //   1 = 7'b1111001;
     //   2 = 7'b0100100;
     //   3 = 7'b0110000;
     //   4 = 7'b0011001;
     //   5 = 7'b0010010;
     //   6 =  7'b0000010;
     //   7 = 7'b1111000;
     //   8 = 7'b0000000;
     //   9 = 7'b0010000;
     //   F =  7'b0001110;
     //   G = 7'b0000010;;
     //   H = 7'b0001001;
     //   I = 7'b1111001;
     //   P = 7'b0001100;
     //   t = 7'b0000111;
     //   E = 7'b0000110;
     //   q = 7'b0011000;
     //   - = 7'b0111111;
     //   default = 7'b1111111;


always @(*) 
begin
    
   case(units)
		0: hex_units <= 7'b1000000;
		1: hex_units <= 7'b1111001;
		2: hex_units <= 7'b0100100;
		3: hex_units <= 7'b0110000;
		4: hex_units <= 7'b0011001; 
		5: hex_units <= 7'b0010010;
		6: hex_units <= 7'b0000010;
		7: hex_units <= 7'b1111000;
		8: hex_units <= 7'b0000000;
		9: hex_units <= 7'b0010000;
		default: hex_units <= 7'b1000000;
   endcase

   case(tens)
		0: hex_tens <= 7'b1000000;
		1: hex_tens <= 7'b1111001;
		2: hex_tens <= 7'b0100100;
		3: hex_tens <= 7'b0110000;
		4: hex_tens <= 7'b0011001; 
		5: hex_tens <= 7'b0010010;
		6: hex_tens <= 7'b0000010;
		7: hex_tens <= 7'b1111000;
		8: hex_tens <= 7'b0000000;
		9: hex_tens <= 7'b0010000;
		default: hex_tens <= 7'b1000000;
   endcase	

   case (game_state)

	S_startup,  S_countdown:
        begin 
            hex5 = sw ? 7'b0100100 : 7'b1111001;
            hex4 = 7'b0001100;
				hex3 = 7'b1111111;
            hex2 = 7'b1111111;
            hex1 = 7'b1111111;
				hex0 = 7'b1111111;
        end

	S_gameover:
      begin 
      // HEX5–HEX4 = P1/P2/Eq
      case (winner)
			2'b00: 
			begin 
				hex5 = 7'b0000110; 
				hex4 = 7'b0011000; 
				hex3 = 7'b0111111;
				hex2 = hex_tens; // onluk
				hex1 = hex_units; // birlik
				hex0 = 7'b0111111;
			end

			2'b10: 
			begin 
				hex5 = 7'b0001100; 
				hex4 = 7'b1111001; 
				hex3 = 7'b0111111;
				hex2 = hex_tens; // onluk
				hex1 = hex_units; // birlik
				hex0 = 7'b0111111;
			end

			2'b01: 
			begin 
				hex5 = 7'b0001100; 
				hex4 = 7'b0100100; 
				hex3 = 7'b0111111;
				hex2 = hex_tens; // onluk
				hex1 = hex_units; // birlik
				hex0 = 7'b0111111;
			end
		endcase
		end
		
	default:
	begin 
		hex5 = 7'b0001110;
		hex4 = 7'b1111001;
		hex3 = 7'b0000010;
		hex2 = 7'b0001001;
		hex1 = 7'b0000111;
		hex0 = 7'b1111111;
	end
	
	endcase
		

end

endmodule