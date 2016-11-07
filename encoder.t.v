`include "encoder.v"

module test_encoder();

reg [7:0] d_in;

wire [2:0] d_out;

encodernbit #(.N(3)) enc(d_in, d_out);

initial begin

	$dumpfile("encoder.vcd");
	$dumpvars;

	d_in = 8'b01000000;
	#100;
	$finish();
end

endmodule

