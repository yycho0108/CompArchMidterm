`ifndef __INPUTCONDITIONER_T_V__
`define __INPUTCONDITIONER_T_V__
`include "defs.v"

`include "inputconditioner.v"

//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------

module testConditioner();

    reg clk;
    reg pin;
    wire conditioned;
    wire rising;
    wire falling;
    
    inputconditioner #(.T(4)) dut(clk, pin, conditioned, rising, falling); // input conditioner with delay 4

	integer seed = 2; // seed for random
	integer it; // iterator

    // Generate clock (50MHz)
	always begin
		`CLKH
		clk=!clk;    // 50MHz Clock
	end

	initial begin
    	$dumpfile("inputconditioner.vcd");
		$dumpvars(0, testConditioner);

		$display("P C R F");

		clk=0;

		for(it = 0; it < 100; it=it+1) begin
			pin = {$random(seed)} % 2; // either 0 or 1, completely random
			#1000; // wait for a duration of time misaligned to the clock, to demonstrate synchronization
			$display("%b %b %b %b", pin, conditioned, rising, falling);
		end

		$finish(); // necessary to end simulation
	end

    
endmodule
`endif
