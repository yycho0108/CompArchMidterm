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

		for(i = 0; i < 20; i=i+1) begin
			btn = {$random(seed)} % 2; // either 0 or 1, completely random
			#2000;
			btn = 0; // release
			#10000;
		end

		#10000;

		$finish(); // necessary to end simulation

end
endmodule
