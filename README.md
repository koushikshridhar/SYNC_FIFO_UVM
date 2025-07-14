# UVM Testbench for Synchronous FIFO

This repository contains a UVM-based testbench to verify a parameterized synchronous FIFO design (`synchronous_fifo.sv`). All design and testbench files are present in a single directory.

---

## ✅ Design: `synchronous_fifo`

A configurable synchronous FIFO with parameters:

- `DEPTH` – FIFO depth (default: 8)
- `DATA_WIDTH` – Data width (default: 8)

**Ports:**
- `clk`, `rst_n` – Clock and active-low reset
- `w_en`, `r_en` – Write/read enables
- `data_in`, `data_out` – Data input/output
- `full`, `empty` – FIFO status flags

---

## 🧪 UVM Testbench Overview

The UVM testbench applies randomized write/read traffic and uses a scoreboard to validate FIFO behavior.

### UVM Components

| File                 | Description                                 |
|----------------------|---------------------------------------------|
| `fifo_if.sv`         | Virtual interface connecting DUT & TB       |
| `fifo_transaction.sv`| UVM sequence item (`wr_rd`, `data`)         |
| `fifo_driver.sv`     | Drives transactions into FIFO               |
| `fifo_monitor.sv`    | Observes DUT behavior (1-cycle read delay)  |
| `fifo_sequence.sv`   | Generates randomized test scenarios         |
| `fifo_sequencer.sv`  | Sequencer for driver                        |
| `fifo_agent.sv`      | Encapsulates driver, monitor, sequencer     |
| `fifo_scoreboard.sv` | Compares expected vs actual FIFO behavior   |
| `fifo_env.sv`        | Instantiates agent and scoreboard           |
| `fifo_test.sv`       | Main UVM test logic                         |
| `testbench.sv`       | Top-level testbench                         |
| `fifo_pkg.sv`        | Includes all testbench classes              |
| `top.sv`             | DUT instantiation + interface connection    |

---

## ✅ Scoreboard Behavior

- Stores all `write` transactions as expected
- Stores all `read` transactions (delayed 1 clk) as actual
- Compares both queues in `report_phase`
- Logs each comparison:
  - ✅ `Match @ i: expected=0xXX actual=0xXX`
  - ❌ `Mismatch @ i: expected=0xXX actual=0xYY`
- Summary:
  - `TEST PASSED`
  - `TEST FAILED`

---

## ▶️ Running Simulation

Use EdaPlayground for easy simulation
