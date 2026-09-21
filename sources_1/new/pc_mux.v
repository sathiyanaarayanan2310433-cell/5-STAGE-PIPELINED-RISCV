module pc_mux(
input [31:0] normal_pc,
input [31:0] out_address,
input branch_enable,
output wire [31:0] next_pc
);

assign next_pc = (branch_enable) ? out_address : normal_pc;

endmodule