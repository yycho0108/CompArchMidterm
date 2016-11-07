`ifndef __JKFLIPFLOP_V__
`define __JKFLIPFLOP_V__

`include "defs.v"
`include "dflipflop.v"

module jkflipflop
(
	input clk,
	input j,
	input k,
	output q,
	output _q
);

///wire _k;
///wire rq = ( (q === (1'bx)) ? 1'b0 : q); //force resolve q
///wire _rq = ~rq; 
///
///`AND nj(a, _rq, j);
///`NOT n1(_k, k);
///`AND nk(b, rq, _k);
///`OR od(d, a, b);
///
///dflipflop dff(clk, d, q, _q);

wire rq, _rq, _clk, clk_posedge;

assign rq = ( (q === (1'bx)) ? 1'b0 : q); //force resolve q
assign _rq = ~rq; 

`JKNOT (_clk, clk); // posedge

`AND (clk_posedge, _clk, clk);// 30 + 20 + 20 + 20 + 20 = 110

`NAND na_r(_r, k, clk_posedge, rq); // _r = true when k = 0
`NAND na_s(_s, j, clk_posedge, _rq); // _s = true when j = 0
`NAND na_q(q,_s,_q);
`NAND na_nq(_q,_r ,q);

endmodule

`endif
