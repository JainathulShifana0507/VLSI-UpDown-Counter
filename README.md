# Verilog HDL: 4-Bit Synchronous Up/Down Counter

## Project Overview
This project implements and verifies two 4-bit synchronous counters using Verilog HDL:
1. Synchronous Up Counter
2. Synchronous Up/Down Counter

Both designs use a rising-edge-triggered clock and a synchronous, active-high reset.

## Features
- 4-bit counter with 16 states (0–15)
- Synchronous reset
- Up-counting and down-counting control
- Upward rollover from 15 to 0
- Downward rollover from 0 to 15
- Self-checking Verilog testbenches
- Simulation waveform visualization using GTKWave

## Technology Stack
- Verilog HDL
- Icarus Verilog — RTL simulation
- GTKWave — waveform analysis
- Visual Studio Code — code editing

## Project Structure
- `rtl/` — counter RTL modules
- `testbench/` — testbenches for both designs
- `docs/` — waveform screenshot
- `README.md` — project documentation
- `.gitignore` — excludes generated simulation files

## Counter Operation

### Synchronous Up Counter
- `reset = 1`: count becomes 0 at the next rising clock edge.
- `reset = 0`: count increments by 1 at each rising edge.
- The counter wraps from 15 to 0.

### Synchronous Up/Down Counter
- `reset = 1`: count becomes 0 at the next rising clock edge.
- `reset = 0`, `up_down = 1`: count increments by 1.
- `reset = 0`, `up_down = 0`: count decrements by 1.
- The counter wraps between 0 and 15.

## Verification
Both testbenches were simulated using Icarus Verilog.

- Up-counter testbench: all implemented checks passed.
- Up/down-counter testbench: all implemented checks passed.
- Tests cover reset behavior, counting sequences, and rollover conditions.
- The up/down counter testbench also verifies that synchronous reset does not change the count immediately when asserted between rising clock edges.

## Waveform
See [`docs/up_down_counter_waveform.png`](docs/up_down_counter_waveform.png) for the up/down counter simulation waveform captured in GTKWave.

## Learning Outcomes
- Sequential digital logic design
- Verilog RTL coding
- Synchronous reset implementation
- Testbench development and functional verification
- Simulation waveform analysis and debugging