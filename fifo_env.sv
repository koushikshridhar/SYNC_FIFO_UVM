class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)

  fifo_agent agent;
  fifo_scoreboard sbd;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = fifo_agent::type_id::create("agent", this);
    sbd = fifo_scoreboard::type_id::create("sbd", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.mon_port.connect(sbd.sb_export);
    `uvm_info("DEBUG", $sformatf("Is agent.monitor null? %0b", agent.monitor == null), UVM_LOW)

  endfunction
endclass
