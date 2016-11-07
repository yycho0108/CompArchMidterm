all : run

build: dff.o jff.o ringcounter.o upcounter.o inputconditioner.o bikelight.o encoder.o

run : build
	./dff.o && ./jff.o && ./ringcounter.o && ./upcounter.o ./inputconditioner.o && ./bikelight.o && ./encoder.o


dff.o : dflipflop.v dflipflop.t.v muxnbit.v sr_latch.v defs.v
	iverilog dflipflop.t.v -o dff.o
jff.o : jkflipflop.v jkflipflop.t.v defs.v
	iverilog jkflipflop.t.v -o jff.o

ringcounter.o : dff.o ringcounter.t.v ringcounter.v defs.v
	iverilog ringcounter.t.v -o ringcounter.o

upcounter.o : jff.o upcounter.t.v upcounter.v defs.v
	iverilog upcounter.t.v -o upcounter.o

inputconditioner.o : inputconditioner.v ringcounter.o inputconditioner.t.v defs.v
	iverilog inputconditioner.t.v -o inputconditioner.o

encoder.o : encoder.v encoder.t.v defs.v
	iverilog encoder.t.v -o encoder.o

bikelight.o : bikelight.v bikelight.t.v inputconditioner.o upcounter.o defs.v
	iverilog bikelight.t.v -o bikelight.o

clean :
	rm -rf *.o
