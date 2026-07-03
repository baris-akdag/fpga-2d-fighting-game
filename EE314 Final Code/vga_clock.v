module vga_clock //25Mhz clock generator
(
	input clk,
	output reg vga_clock
);

always @(posedge clk) 
begin

	vga_clock <= ~vga_clock;
	
end

endmodule