`ifndef __RINGCOUNTER_T_V__
`define __RINGCOUNTER_T_V__

`include "defs.v"
`include "ringcounter.v"

module test_ringcounter();

reg clk = 0;
reg en = 0;
reg reset = 1;
wire [5:0] q;

integer i;

ringcounter #(.N(6)) rc(clk, en,q);

always begin
	`CLKH
	clk = !clk;
end

initial begin
	$dumpfile("ringcounter.vcd");
	$dumpvars;

	en = 0;
	reset = 1;
	for(i=0;i<10;i=i+1) begin
		`CLK;
	end

	en = 1;
	reset = 0;
	for(i=0;i<100;i=i+1) begin
		`CLK;
	end
	$finish();
end

endmodule
`endif
