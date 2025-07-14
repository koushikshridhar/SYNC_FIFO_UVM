`include "fifo_if.sv"
`include "fifo_pkg.sv"

module top;
  import uvm_pkg::*;
  import fifo_pkg::*;

  logic clk, rst_n;
  fifo_if fifo_if_inst(clk, rst_n);

  synchronous_fifo dut (
      .clk(clk),
      .rst_n(rst_n),
      .w_en(fifo_if_inst.w_en),
      .r_en(fifo_if_inst.r_en),
      .data_in(fifo_if_inst.data_in),
      .data_out(fifo_if_inst.data_out),
      .full(fifo_if_inst.full),
      .empty(fifo_if_inst.empty)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst_n = 0;
    #20 rst_n = 1;
  end

  initial begin
    uvm_config_db #(virtual fifo_if)::set(null, "*", "vif", fifo_if_inst);
    run_test("fifo_test");
  end
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
