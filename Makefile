#compiler and simulator
IVERILOG = iverilog
VVP = vvp

# Directories and files for Seq_Mult
MULTIPLIER_VERILOG_FILES = src/Controller.sv src/Datapath.sv src/Seq_Mul_top.sv test/tb.sv
MULTIPLIER_OUTPUT_FILE = out.vvp

# Default target
all: mult

#Compile and simulate multiplier
mult: compile_mult simulate_mult

compile_mult:
	$(IVERILOG) -g2012 -o $(MULTIPLIER_OUTPUT_FILE) $(MULTIPLIER_VERILOG_FILES)

simulate_mult:
	$(VVP) $(MULTIPLIER_OUTPUT_FILE)

#Clean up generated files
clean:
	rm -f $(MULTIPLIER_OUTPUT_FILE) tb.vcd

.PHONY: all mult compile_mult simulate_mult clean

