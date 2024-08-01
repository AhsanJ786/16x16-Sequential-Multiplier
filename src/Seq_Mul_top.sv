
module Seq_Mul_top(Multiplicand,Multiplier,clk,rst,start,ready,Product);
input logic [15:0] Multiplicand,Multiplier;
input logic clk,rst,start;
output logic ready;
output logic [31:0] Product;

//
logic mux_sel_Mul,clear,count_comp;
logic [1:0] Qo_Q1;
logic [1:0] mux_sel_Shift;

Datapath DP(.Multiplicand(Multiplicand),
            .Multiplier(Multiplier),
            .clk(clk),
            .rst(rst),
            .Product(Product),
            .Qo_Q1(Qo_Q1),
            .mux_sel_Mul(mux_sel_Mul),
            .mux_sel_Shift(mux_sel_Shift),
            .clear(clear),
            .count_comp(count_comp));

controller   CU(.clk(clk),
                .rst(rst),
                .ready(ready),
                .start(start),
                .clear(clear),
                .count_comp(count_comp),
                .Qo_Q1(Qo_Q1),
                .mux_sel_Mul(mux_sel_Mul),
                .mux_sel_Shift(mux_sel_Shift));


endmodule