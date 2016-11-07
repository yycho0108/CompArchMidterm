`include "bikelight.v"
`include "encoder.v"

module fpga_wrapper(
	input clk,
	input [3:0] sw, // not used
	input [3:0] btn, // btn[0] for toggling light mode
	output [3:0] led //led[0] for bike light, led[1] and led[2] for showing state
);

wire [3:0] state;
wire bikelight_led;
bikelight bklt(clk, btn[0], state, bikelight_led);

// alternatively,
// encoder enc(clk, led[1:2], blkt.state);
// encoding...
//assign led = state;

//assign led[1] = state[1] | state[3]; // low bit
//assign led[2] = state[2] | state[3]; // high bit

//always @(posedge clk) begin
    //if(sw[0] == 1'b0) begin
    assign led = state; // set to state
    //end else begin
    //    led[0] = bikelight_led;
    //end
//end

endmodule
