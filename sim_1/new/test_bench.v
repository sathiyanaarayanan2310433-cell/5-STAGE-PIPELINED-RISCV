module test_bench;

reg clk;
reg rst;

pipeline_datapath dut (
    .clk(clk),
    .rst(rst)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    #22;
    rst = 0;
    #150;
    $finish;
end

endmodule