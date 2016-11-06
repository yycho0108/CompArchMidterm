`define NOT not #10
`define NAND nand #20
`define AND and #30
`define NOR nor #20
`define OR or #30
`define XNOR xnor #50
`define XOR xor #50

module mux1bit
(
	output out,
	input [1:0] data,
	input sel
);
wire out_0, out_1;
wire n_sel;

`NOT not_1(n_sel, sel);
and (out_0, n_sel, data[0]);
and (out_1, sel, data[1]);
`OR or1(out, out_0, out_1);
endmodule

module muxnbit
#(parameter n=4, parameter m=2**n)
(
	output out,
	input [m-1:0] data,
	input [n-1:0] sel
);

wire out_low, out_high;

generate
	if(n == 1) begin // 1-bit mux
		mux1bit _mux1bit (out, data[1:0], sel); 
	end
	else begin
		muxnbit #(.n(n-1)) _muxnbit_low (out_low, data[m/2-1:0], sel[n-2:0]);
		muxnbit #(.n(n-1)) _muxnbit_high(out_high, data[m-1:m/2], sel[n-2:0]);
		mux1bit _mux1bit_2(out,{out_high, out_low}, sel[n-1]); 
	end

endgenerate

endmodule
