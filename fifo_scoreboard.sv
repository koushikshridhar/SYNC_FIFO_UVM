class fifo_scoreboard extends uvm_component;

  `uvm_component_utils(fifo_scoreboard)

  uvm_analysis_imp #(fifo_transaction, fifo_scoreboard) sb_export;

  fifo_transaction expected_q[$];
  fifo_transaction actual_q[$];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    sb_export = new("sb_export", this);
  endfunction

  function void write(fifo_transaction tr);
    if (tr.wr_rd == 1)
      expected_q.push_back(tr);
    else
      actual_q.push_back(tr);
  endfunction

  function void report_phase(uvm_phase phase);
    bit pass = 1;

    if (expected_q.size() != actual_q.size()) begin
      `uvm_error("SBD", $sformatf("Expected size = %0d, Actual size = %0d",
                                  expected_q.size(), actual_q.size()))
      pass = 0;
    end

    foreach (actual_q[i]) begin
      if (i >= expected_q.size()) begin
        `uvm_warning("SBD", $sformatf("Extra read @ %0d: actual=%0h", i, actual_q[i].data))
        pass = 0;
        continue;
      end

      if (actual_q[i].data !== expected_q[i].data) begin
        `uvm_error("SBD", $sformatf("Mismatch @ %0d: expected=0x%0h actual=0x%0h",
                                    i, expected_q[i].data, actual_q[i].data))
        pass = 0;
      end else begin
        `uvm_info("SBD", $sformatf("Match @ %0d: expected=0x%0h actual=0x%0h",
                                   i, expected_q[i].data, actual_q[i].data), UVM_LOW)
      end
    end

    if (pass)
      `uvm_info("SBD", "TEST PASSED", UVM_LOW)
    else
      `uvm_error("SBD", "TEST FAILED")
  endfunction

endclass
