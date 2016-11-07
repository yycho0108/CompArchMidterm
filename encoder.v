`ifndef __ENCODER_V__
`define __ENCODER_V__
`include "defs.v"

// 0001 --> 00
// 0010 --> 01, etc.
//
//
module _encodernbit

#(parameter N = 1, M = 2 ** N)
(
	input [M-1:0] d_in, // M = 2 ** N
	output [N-1:0] d_out, // encoded
	output found
);

wire d_out_h, d_out_l;

generate
	if(N == 1) begin
		assign d_out[0] = d_out[0] | d_in[1];
		assign found = d_in[0] | d_in[1];
	end else begin
		_encodernbit #(.N(N-1)) enc_h(d_in [M-1:M/2], d_out[N-2:0], d_out_h);
		_encodernbit #(.N(N-1)) enc_l(d_in [M/2-1:0], d_out[N-2:0], d_out_l);
		assign d_out[N-1] = d_out[N-1] | (d_out_h | ~d_out_l);
	end
endgenerate

endmodule


module encodernbit
#(parameter N = 1, M = 2 ** N)
(
	input [M-1:0] d_in, // M = 2 ** N
	output [N-1:0] d_out // encoded
);

wire found;

_encodernbit #(.N(N)) enc(d_in, d_out, found);

endmodule

`endif
