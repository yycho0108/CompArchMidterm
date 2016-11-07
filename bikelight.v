`ifndef __BIKELIGHT_V__
`define __BIKELIGHT_V__
`include "inputconditioner.v"
`include "ringcounter.v"
`include "muxnbit.v"
`include "encoder.v"
`include "upcounter.v"

`define s_OFF 2'd00
`define s_ON  2'b01
`define s_BLINK 2'b10
`define s_DIM 2'b11

module bikelight
(
	input clk,
	input btn,
	output [3:0] state,
	output led
);

//wire [3:0] state; // state
wire [3:0] uc_q;

wire ring_en;

inputconditioner #(.T(4)) cd0(clk, btn, ,ring_en, ); // not using conditioned / falling; only trigger on rising

ringcounter #(.N(4)) rc(clk, ring_en, state);  // state == state, reset on indeterminate state ...

upcounter #(.N(4)) uc(clk, uc_q);

assign blink = uc_q[3]; // 1/16 of clock frequency

assign dim = uc_q[0] | uc_q[1]; // 75%

//muxnbit #(.n(2)) mux(led, {dim_clk, blink_clk,1'b1,0'b0}, {state[2]|state[3], state[1]|state[3]});
assign led = ((state[0] & 1'b0) | (state[1] & 1'b1) | (state[2] & blink) | (state[3] & dim));

endmodule
`endif
