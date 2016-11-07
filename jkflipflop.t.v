`include "jkflipflop.v"

module test_jkflipflop();

reg clk=0;
reg j,k;
wire q,_q;

jkflipflop jff(clk, j,k,q,_q);

always begin
	`CLKH
	clk = !clk;
end

initial begin
	$dumpfile("jkflipflop.vcd");
	$dumpvars;

	#1000;

	j=0; k=0;
	#1000;

	j=0; k=1;
	#1000;

	j=1; k=0;
	#1000;

	j=1; k=1;
	#1000;
	$finish();
end

endmodule
