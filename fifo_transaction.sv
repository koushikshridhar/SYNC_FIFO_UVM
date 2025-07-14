class fifo_transaction extends uvm_sequence_item;
    rand bit wr_rd; // 1 = write, 0 = read
    rand bit [7:0] data;

    `uvm_object_utils(fifo_transaction)

    function new(string name = "fifo_transaction");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("wr_rd", wr_rd, $bits(wr_rd));
        printer.print_field_int("data", data, 8);
    endfunction
endclass
