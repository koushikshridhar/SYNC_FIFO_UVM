interface fifo_if #(parameter DATA_WIDTH = 8) (input logic clk, input logic rst_n);
    logic w_en;
    logic r_en;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;
    logic full;
    logic empty;
endinterface
