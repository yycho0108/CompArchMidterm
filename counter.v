`ifndef __COUNTER_V__
`define __COUNTER_V__
`include "defs.v"
`include "dflipflop.v"

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

// currently editing counter
//

assign done = &(c); // all 1

`OR (reset, reset_in, done);

generate
	genvar i;
	for(i=1; i<=N; i=i+1) : gencntblk
		dflipflop dff(clk, d[i-1] & !reset, d[i]);
	end
endgenerate

endmodule
`endif
