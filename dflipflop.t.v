`ifndef __DFLIPFLOP_T_V__
`define __DFLIPFLOP_T_V__
`include "dflipflop.v"

module test_dflipflop();

reg clk=0, en=0, d=0;
wire q, _q;
integer it;

dflipflop_en dffp(clk, en, d,q);

always begin
	`CLKH
	clk = !clk;
end

initial begin
	$dumpfile("dflipflop.vcd");
	$dumpvars;
	en = 0;
	`CLK;
	en = 1;
	d = 1;
	`CLK;
	d = 0;
	`CLK;
	`CLK;
	`CLK;
	d=1;
	`CLK;
	`CLK;
	for(it=0; it<10; it=it+1) begin
		`CLK;
	end

	$finish();
end

endmodule
`endif
