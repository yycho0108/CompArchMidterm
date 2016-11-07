`ifndef __SR_LATCH_V__
`define __SR_LATCH_V__
`include "defs.v"

module sr_latch
(
	input s,
	input r,
	output q,
	output _q
);

`NOR top(q,s,_q);
`NOR bot(_q,r,q);

endmodule
`endif
