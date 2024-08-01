# Sequential Multiplier Project

This project implements a sequential multiplier using SystemVerilog and includes a testbench for simulation.

## Directory Structure

- `src/`
  - `Controller.sv`: The controller module for the sequential multiplier.
  - `Datapath.sv`: The datapath module for the sequential multiplier.
  - `Seq_Mul_top.sv`: The top-level module that integrates the controller and datapath.
- `test/`
  - `tb.sv`: The testbench for the sequential multiplier.
- `Makefile`: The makefile for compiling and simulating the project.

## Makefile Targets

- `all`: Default target, compiles and simulates the sequential multiplier.
- `mult`: Compiles and simulates the sequential multiplier.
- `compile_mult`: Compiles the Verilog files for the sequential multiplier.
- `simulate_mult`: Simulates the compiled Verilog files using the VVP simulator.
- `clean`: Cleans up the generated files.

## Usage

### Compiling and Simulating

To compile and simulate the sequential multiplier, run:

```sh
make 

