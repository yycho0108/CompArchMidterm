`include "inputconditioner.v"
`include "ringcounter.v"
`include "muxnbit.v"
`include "encoder.v"

`define s_OFF 2'd00
`define s_ON  2'b01
`define s_BLINK 2'b10
`define s_DIM 2'b11

module bikelight
(
	input clk,
	input btn,
	output led
);

// assume existence of blink_clk
reg blink_clk = 0;
always begin
	#5000;
	blink_clk = !blink_clk;
end

reg dim_clk;
always begin
	#250;
	dim_clk = 1;
	#750;
	dim_clk = 0;
end

wire [3:0] q; // state

wire dummy;

inputconditioner #(.T(4)) cd(clk, btn, ,rising, ); // not using conditioned / falling; only trigger on rising

ringcounter #(.N(4)) rc(clk, rising, q);  // q == state, reset on indeterminate q ...

//muxnbit #(.n(2)) mux(led, {dim_clk, blink_clk,1'b1,0'b0}, {q[2]|q[3], q[1]|q[3]});
assign led = ((q[0] & 1'b0) | (q[1] & 1'b1) | (q[2] & blink_clk) | (q[3] & dim_clk));


endmodule
