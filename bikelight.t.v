`timescale 1ns / 1ps
`include "bikelight.v"

module test_bikelight();

reg clk = 0;
reg btn = 0;

bikelight bklt(clk, btn, led);

integer seed = 3;
integer i = 0;

always begin
	#250 clk = !clk;
end

initial begin
    	$dumpfile("bikelight.vcd");
		$dumpvars(0, test_bikelight);

		clk=0;

		for(i = 0; i < 100; i=i+1) begin
			btn = {$random(seed)} % 2; // either 0 or 1, completely random
			#1000; // wait for a duration of time misaligned to the clock, to demonstrate synchronization
		end

		$finish(); // necessary to end simulation

end
endmodule
