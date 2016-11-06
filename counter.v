`include "dflipflop.v"
`define OR or #50

// =====================
// Counter
// Counts to given parameter
// and emits "done" when fully counted, and resets itself
// it also resets when reset_in is true
// =====================

module counter
(
	input clk,
	input reset_in,
	output done
);
reg done;
wire reset;

`OR (reset, reset_in, done);

// currently editing counter
//
dflipflop dff0(clk,d,q);

and(done, c[0], c[1], c[2]);

endmodule
