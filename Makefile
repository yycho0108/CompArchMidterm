all : run

dff.o : dflipflop.v dflipflop.t.v muxnbit.v sr_latch.v
	iverilog dflipflop.t.v -o dff.o

ringcounter.o : dff.o ringcounter.t.v ringcounter.v
	iverilog ringcounter.t.v -o ringcounter.o

inputconditioner.o : inputconditioner.v ringcounter.o inputconditioner.t.v
	iverilog inputconditioner.t.v -o inputconditioner.o

bikelight.o : bikelight.v bikelight.t.v inputconditioner.o
	iverilog bikelight.t.v -o bikelight.o

build: dff.o ringcounter.o inputconditioner.o bikelight.o

run : build
	./dff.o && ./ringcounter.o && ./inputconditioner.o && ./bikelight.o
