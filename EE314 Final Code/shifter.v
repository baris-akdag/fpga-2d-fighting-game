module shifter #(parameter W = 4)
(
	input clk,
	input[1:0] control, // 00 is right shift, 01 is left shift, 10 is load
	input padding, //is it padding with 0 or 1 
	input[W-1:0] load_input,
	output reg[W-1:0] shifted 
);

localparam right_shift = 2'b00;
localparam left_shift = 2'b01;
localparam load = 2'b10;

always@(posedge clk)
begin
	case(control)
		right_shift:
			shifted <= {padding , shifted[W-1:1]};
		left_shift:
			shifted <= {shifted[W-2:0] , padding};
		load:
			shifted <= load_input;
		default:
			shifted <= shifted;
	endcase
end
endmodule