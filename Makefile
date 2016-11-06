all : dff.o ringcounter.o

dff.o : dflipflop.v dflipflop.t.v muxnbit.v sr_latch.v
	iverilog dflipflop.t.v -o dff.o

ringcounter.o : dflipflop.v ringcounter.t.v ringcounter.v
	iverilog ringcounter.t.v -o ringcounter.o

run :
	./dff.o
