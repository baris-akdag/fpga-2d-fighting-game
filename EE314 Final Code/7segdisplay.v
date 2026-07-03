module sevenseg_display //work in progress not working as intended yet
(
	input clk,
	input[3:0] state,
	input toggle,
	output reg [6:0] hex0,
	output reg [6:0] hex1,
	output reg [6:0] hex2,
	output reg [6:0] hex3,
	output reg [6:0] hex4,
	output reg [6:0] hex5
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

always @(posedge clk)
begin
	if ((state == S_startup) && (toggle == 0)) 
	begin
		hex1 <= 7'b1111001;
		hex0 <= 7'b0001100;
	end
	
	else if ((state == S_startup) && (toggle == 1)) 
	begin
		hex1 <= 7'b0100100;
		hex0 <= 7'b0001100;
	end
	
end

endmodule