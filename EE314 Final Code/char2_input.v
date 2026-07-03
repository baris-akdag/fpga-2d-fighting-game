module char2_input
(
input random_right,
input random_left,
input random_attack,

input right,
input left,
input attack,

input sw,

output reg right_out,
output reg left_out,
output reg attack_out

);

always@(*)
begin
	if (sw)
	begin
		right_out <= right;
		left_out <= left;
		attack_out <= attack;
	end
	else
	begin
		right_out <= random_right;
		left_out <= random_left;
		attack_out <= random_attack;
	end	
end
endmodule