class fifo_sequence extends uvm_sequence #(fifo_transaction);
    `uvm_object_utils(fifo_sequence)

    function new(string name = "fifo_sequence");
        super.new(name);
    endfunction

    task body();
        fifo_transaction tr;

        repeat (10) begin
            tr = fifo_transaction::type_id::create("tr");
            tr.randomize() with { wr_rd == 1; }; // Write
            start_item(tr);
            finish_item(tr);
        end

        repeat (10) begin
            tr = fifo_transaction::type_id::create("tr");
            tr.randomize() with { wr_rd == 0; }; // Read
            start_item(tr);
            finish_item(tr);
        end
    endtask
endclass
