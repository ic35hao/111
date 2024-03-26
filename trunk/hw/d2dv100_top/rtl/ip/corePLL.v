
module corePLL
(
    output  wire    locked,
    input   wire    reset,
    output  wire    clk_out1,
    input   wire    clk_in1
);

assign clk_out1 = reset ? 1'b0 : clk_in1;
assign locked = ~reset;

endmodule