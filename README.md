# Verilog HDL: 4-Bit Synchronous Up/Down Counter

A digital design and functional verification project implementing a 4-bit synchronous up counter and a 4-bit synchronous up/down counter using Verilog HDL.

## 1. Project Overview

This project demonstrates the design, simulation, and verification of two sequential digital circuits:

- **Synchronous Up Counter**
- **Synchronous Up/Down Counter**

Both counters operate on the rising edge of the clock and use an active-high synchronous reset.

The project focuses on RTL design, sequential logic, self-checking testbenches, rollover behaviour, and waveform-based debugging.

## 2. Design Specifications

| Parameter | Description |
|---|---|
| Counter width | 4 bits |
| Number of states | 16 |
| Count range | 0–15 |
| Clock triggering | Positive edge |
| Reset type | Synchronous |
| Reset polarity | Active-high |
| HDL | Verilog |

## 3. Features

- 4-bit binary counting
- Synchronous reset to `0000`
- Separate up-counter and up/down-counter modules
- Direction control using the `up_down` signal
- Automatic rollover at the counting limits
- Self-checking testbenches
- Simulation waveform generation and analysis

## 4. Block Diagram

```text
                 +-----------------------+
 Clock --------->|                       |
 Reset --------->|  4-Bit Synchronous     |----> 4-bit Count
 up_down ------->|  Up/Down Counter       |
                 |                       |
                 +-----------------------+
```

The `up_down` input controls the counting direction in the up/down counter. The separate synchronous up counter does not require this control input.

## 5. Counter Operation

### 5.1 Synchronous Up Counter

| Reset | Operation at rising clock edge |
|---|---|
| `1` | Count resets to `0000` |
| `0` | Count increments by 1 |

Example sequence:

`0000 → 0001 → 0010 → ... → 1111 → 0000`

### 5.2 Synchronous Up/Down Counter

| Reset | `up_down` | Operation |
|---|---|---|
| `1` | X | Reset to `0000` |
| `0` | `1` | Increment by 1 |
| `0` | `0` | Decrement by 1 |

Example up-counting sequence:

`0000 → 0001 → 0010 → ... → 1111 → 0000`

Example down-counting sequence:

`0000 → 1111 → 1110 → ... → 0001 → 0000`

Because the counter is 4-bit wide, arithmetic naturally wraps around modulo 16.

## 6. Repository Structure

```text
VLSI_UpDown_Counter/
├── rtl/
│   ├── sync_up_counter.v
│   └── sync_up_down_counter.v
├── testbench/
│   ├── tb_sync_up_counter.v
│   └── tb_sync_up_down_counter.v
├── docs/
│   └── up_down_counter_waveform.png
├── .gitignore
└── README.md
```

- `rtl/` — synthesizable counter designs
- `testbench/` — simulation stimulus and output checks
- `docs/` — captured simulation waveform
- `.gitignore` — excludes generated simulation files and waveforms

## 7. Verification and Test Cases

Both designs were simulated using Icarus Verilog with self-checking testbenches.

The implemented checks cover:

- Reset behaviour at a rising clock edge
- Normal up-counting operation
- Up/down counting direction
- Up-counter rollover from 15 to 0
- Down-counter rollover from 0 to 15
- Reset behaviour when asserted between rising clock edges

The testbenches report individual pass/fail results and a final test summary.

**Verification status:** All implemented checks passed in the recorded simulation runs.

## 8. Running the Simulation

Install [Icarus Verilog](https://steveicarus.github.io/iverilog/) and ensure that `iverilog` and `vvp` are available in your terminal.

### Up Counter

```bash
iverilog -o counter_sim rtl/sync_up_counter.v testbench/tb_sync_up_counter.v
vvp counter_sim
```

### Up/Down Counter

```bash
iverilog -o up_down_sim rtl/sync_up_down_counter.v testbench/tb_sync_up_down_counter.v
vvp up_down_sim
```

To inspect generated waveforms, open the relevant `.vcd` file in GTKWave. The testbenches generate `counter.vcd` and `up_down_counter.vcd`, respectively.

## 9. Simulation Waveform

The waveform below is included in the repository:

[View Up/Down Counter Waveform](docs/up_down_counter_waveform.png)

The waveform can be used to inspect clock transitions, reset behaviour, the direction-control signal, and the counter output over time.

## 10. Tools and Technologies

- **Verilog HDL** — RTL design
- **Icarus Verilog** — compilation and simulation
- **GTKWave** — waveform inspection
- **Visual Studio Code** — development environment
- **Git and GitHub** — version control and project hosting

## 11. Learning Outcomes

- Designing sequential circuits using Verilog HDL
- Understanding clocked logic and synchronous reset
- Implementing binary up/down counters
- Writing self-checking testbenches
- Verifying rollover and boundary conditions
- Analysing simulation waveforms
- Managing RTL projects with Git and GitHub

## 12. Future Improvements

- Add parameterised counter width
- Add additional boundary-condition and reset test cases
- Explore FPGA synthesis and resource utilisation
- Implement an FPGA-based demonstration using switches, clock input, and LEDs

---

**Project focus:** RTL Design | Digital Electronics | Functional Verification | Verilog HDL
