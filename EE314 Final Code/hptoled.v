module hptoled
(
	input [1:0] char_hp,
	input [1:0] char2_hp,
	input [1:0] char_bp,
	input [1:0] char2_bp,
	
	output reg[9:0] led
);

always@(*)
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
	
	case(char2_bp)
		2'b00: led[5:3] <= 3'b111;
		2'b01: led[5:3] <= 3'b011;
		2'b10: led[5:3] <= 3'b001;
		2'b11: led[5:3] <= 3'b000;
	endcase

	
end

endmodule