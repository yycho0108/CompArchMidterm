`ifndef __RINGCOUNTER_T_V__
`define __RINGCOUNTER_T_V__

`include "defs.v"
`include "upcounter.v"

`define WAIT #500
module test_upcounter();

reg clk = 0;
reg en = 0;
wire [3:0] q;

integer i;

upcounter #(.N(4)) uc(clk, en, q);

always begin
	`WAIT;
	clk = !clk;
end

initial begin
	$dumpfile("upcounter.vcd");
	$dumpvars;

	en = 0;
	for(i=0;i<10;i=i+1) begin
		`WAIT;
	end
	en = 1;
	for(i=0;i<100;i=i+1) begin
		`WAIT;
	end
	$finish();
end

endmodule
`endif
