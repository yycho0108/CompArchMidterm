`timescale 1ns / 1ps
`include "bikelight.v"

module test_bikelight();

reg clk = 0;
reg btn = 0;
wire [3:0] state;
bikelight bklt(clk, btn, state, led);

integer seed = 449;
integer i = 0;
integer j = 0;

always begin
	`CLKH clk = !clk;
end

initial begin
    	$dumpfile("bikelight.vcd");
		$dumpvars(0, test_bikelight);

		clk=0;

		for(i = 0; i < 20; i=i+1) begin
			btn= {$random(seed)} % 2; // either 0 or 1, completely random
			for(j=0; j<160; j=j+1) begin
				`CLK;
			end

			btn= 0; // release

			for(j=0; j<100; j=j+1) begin
				`CLK;
			end
		end

		$finish(); // necessary to end simulation

end
endmodule
