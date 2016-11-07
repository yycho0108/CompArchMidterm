`ifndef __DFLIPFLOP_T_V__
`define __DFLIPFLOP_T_V__
`include "dflipflop.v"

`define WAITH #250
`define WAIT #500

module test_dflipflop();

reg clk=0, en=0, d=0;
wire q, _q;
integer it;

dflipflop_en dffp(clk, en, d,q);

always begin
	`WAITH
	clk = !clk;
end

initial begin
	$dumpfile("dflipflop.vcd");
	$dumpvars;
	en = 0;
	`WAIT;
	`WAIT;
	en = 1;
	d = 1;
	`WAIT;
	`WAIT;
	`WAIT;
	d = 0;
	`WAIT;
	for(it=0; it<10; it=it+1) begin
		`WAIT;
	end

	$finish();
end

endmodule
`endif
