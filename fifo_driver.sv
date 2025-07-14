class fifo_driver extends uvm_driver #(fifo_transaction);
    virtual fifo_if vif;

    `uvm_component_utils(fifo_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual fifo_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not set for driver")
    endfunction

    task run_phase(uvm_phase phase);
        fifo_transaction tr;
      wait(vif.rst_n);
        forever begin
            seq_item_port.get_next_item(tr);
            @(posedge vif.clk);
            if (tr.wr_rd) begin
                vif.w_en <= 1;
                vif.r_en <= 0;
                vif.data_in <= tr.data;
            end else begin
                vif.w_en <= 0;
                vif.r_en <= 1;
            end
            @(posedge vif.clk);
            vif.w_en <= 0;
            vif.r_en <= 0;
            seq_item_port.item_done();
        end
    endtask
endclass
