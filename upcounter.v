`ifndef __UPCOUNTER_V__
`define __UPCOUNTER_V__

`include "jkflipflop.v"

// ====================================================================================
// UpCounter 
// In the module, I had to create a reset signal to force the pin states,
// because verilog didn't realize that the counter ultimately resolve to 0
// after a period of time no matter the initial state.
// ====================================================================================

module upcounter 
#(parameter N=4)
(
	input clk,
	input en,
	output [N-1:0] q
);

// --- non-parametrized version
//wire q01, q012;
//jkflipflop jff0(clk, 1'b1, 1'b1, q[0],);
//`AND a0(j0, 1, q[0]); // --> j[0]
//jkflipflop jff1(clk, q[0], q[0], q[1],);
//`AND a1(q01, q[0], q[1]); // --> j[1] = j[0] & q[1]
//jkflipflop jff2(clk, q01, q01, q[2],);
//`AND a2(q012,q01, q[2]);
//jkflipflop jff3(clk, q012, q012, q[3],);
//
//endmodule
//

wire [N:0] j;

assign j[0] = 1'b1;

generate
	genvar i;
	for(i = 0; i < N; i = i + 1) begin: upgenblk
		`AND (j[i+1], j[i], q[i]);
		jkflipflop jff(clk, j[i], j[i], q[i],); // don't care about _q
	end
endgenerate

endmodule

`endif
