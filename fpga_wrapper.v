`include "bikelight.v"

module fpga_wrapper(
	input clk,
	input [3:0] sw, // not used
	input [3:0] btn, // btn[0] for toggling light mode
	output reg [3:0] led //led[0] for bike light, led[1] and led[2] for 
);

bikelight blkt(clk, btn[0], led[0]);

// alternatively,
// encoder enc(clk, led[1:2], blkt.q);
// encoding...

assign led[1] = blkt.q[1] | blkt.q[3]; // low bit
assign led[2] = blkt.q[2] | blkt.q[3]; // high bit

always @ posedge(clk) begin

end


endmodule
