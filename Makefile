all : dff.o ringcounter.o inputconditioner.o

dff.o : dflipflop.v dflipflop.t.v muxnbit.v sr_latch.v
	iverilog dflipflop.t.v -o dff.o

ringcounter.o : dflipflop.v ringcounter.t.v ringcounter.v
	iverilog ringcounter.t.v -o ringcounter.o

inputconditioner.o : inputconditioner.v ringcounter.v dflipflop.v inputconditioner.t.v
	iverilog inputconditioner.t.v -o inputconditioner.o

run :
	./dff.o
