`ifndef __DFLIPFLOP_V__
`define __DFLIPFLOP_V__
`include "defs.v"
`include "muxnbit.v"

module dflipflop
(
	input  clk,
	input    d,
	output   q
);

wire _s,_r, wa, wb, _q;

// intermediate values
`NAND na_a(wa, _r, d);
`NAND na_b(wb, wa, _s);

// _S,_R
`NAND na_s(_s, wb, clk);
`NAND na_r(_r, _s, wa, clk);

// S,R final results
`NAND na_q(q,_s,_q);
`NAND na_nq(_q,_r,q);

endmodule

module dflipflop_en
(
	input  clk,
	input   en,
	input    d,
	output   q
);

wire din;


muxnbit #(.n(1)) mux(din, {d,q}, en); // en == 1 --> d, en == 0 --> q
dflipflop dff(clk,din,q);

endmodule
`endif
