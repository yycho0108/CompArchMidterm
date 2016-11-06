`include "dflipflop.v"
`define NOR nor

module ringcounter

// in the module, I had to use the reset signal because verilog didn't realize
// that the counter resolves to 0 after a period of time passes no matter
// what.

#(parameter N=4)
(
	input clk,
	input en,
	input reset,
	output [N-1:0] q
);

wire [N:0] d;

generate
	genvar i;
	for(i = 1; i <= N; i = i + 1) begin: ringgenblk
		//dflipflop clk, en, d, q
		dflipflop_en dff(clk, en, d[i-1] & !reset, d[i]); // use previous results
	end
endgenerate

assign q = d[N:1];
assign d[0] = ~|d[N-1:1];

endmodule

