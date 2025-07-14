class fifo_test extends uvm_test;
    fifo_env env;

    `uvm_component_utils(fifo_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        env = fifo_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        fifo_transaction tr;
        fifo_sequence seq;

        phase.raise_objection(this);
        seq = fifo_sequence::type_id::create("seq");
        seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass
