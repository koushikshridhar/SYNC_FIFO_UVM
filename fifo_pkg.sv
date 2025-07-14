package fifo_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // Include all components
  `include "fifo_transaction.sv"
  `include "fifo_sequence.sv"
  `include "fifo_driver.sv"
  `include "fifo_monitor.sv"
  `include "fifo_sequencer.sv"
  `include "fifo_agent.sv"
  `include "fifo_scoreboard.sv"   // ✅ include this
  `include "fifo_env.sv"
  `include "fifo_test.sv"

endpackage
