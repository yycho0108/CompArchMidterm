`ifndef __INPUTCONDITIONER_V__
`define __INPUTCONDITIONER_V__
`include "defs.v"
`include "dflipflop.v"
`include "ringcounter.v"

// ====================================================================================
// Input Conditioner
//    1) Synchronizes input to clock domain
//    2) Debounces input
//    3) Creates pulses at edge transitions
// ====================================================================================

module inputconditioner
#(parameter T = 4) // T = delay
(
input 	    clk,            // Clock domain to synchronize input to
input	    sig_in,    // (Potentially) noisy input signal
output wire cond,    // Conditioned output signal
output wire  rising,   // 1 clk pulse at rising edge of cond
output wire  falling    // 1 clk pulse at falling edge of cond
);

wire _clk;

wire reset;
wire _reset;
wire sync0, sync1;
wire [T-1:0] cnts; // counts to 3

`NOT (_clk, clk);
`AND (clk_pe, clk, _clk);

// signal propagation
dflipflop_en dff1(clk, clk, sig_in, sync0); // posedge clock ...
dflipflop_en dff2(clk, clk, sync0, sync1);

// counter reset logic
xor (_reset, cond, sync1); // cond != sync1
not (reset, _reset); //cond == sync1, reset counter to 0

// counter increment logic
// assign en = _reset;
ringcounter #(.N(T)) cnt(clk, 1'b1, reset, cnts); // ring counter always enabled

// now, if count has reached T-1 ...
muxnbit #(.n(1)) mux(cond, {sync1,cond}, cnts[T-1]); // if true choose sync1
`AND pe(rising, sync1, cnts[T-1]);
`AND ne(falling, !sync1, cnts[T-1]);

endmodule
`endif
