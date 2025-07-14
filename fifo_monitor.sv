class fifo_monitor extends uvm_monitor;
    virtual fifo_if vif;
    uvm_analysis_port #(fifo_transaction) mon_port;

    `uvm_component_utils(fifo_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_port = new("mon_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual fifo_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not set for monitor")
    endfunction

    task run_phase(uvm_phase phase);
      fifo_transaction tr;

      forever begin
        @(posedge vif.clk);

        // Capture write
        if (vif.w_en && !vif.full) begin
          tr = fifo_transaction::type_id::create("tr", this);
          tr.wr_rd = 1;
          tr.data  = vif.data_in;
          mon_port.write(tr);
        end

        // Capture read (delay 1 clk)
        if (vif.r_en && !vif.empty) begin
          @(posedge vif.clk);  // Delay to allow data_out to be valid
          tr = fifo_transaction::type_id::create("tr", this);
          tr.wr_rd = 0;
          tr.data  = vif.data_out;
          mon_port.write(tr);
        end
      end
    endtask
endclass
