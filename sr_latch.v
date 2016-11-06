`define NAND nand #5

module sr_latch
(
	input s,
	input r,
	output q,
	output _q
);

`NAND top(q,s,_q);
`NAND bot(_q,r,q);

endmodule
