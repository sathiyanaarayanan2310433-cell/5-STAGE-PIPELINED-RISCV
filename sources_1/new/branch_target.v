module branch_target(
input [31:0] pc,
input [31:0] immediate,
output wire [31:0] branch_address
);

assign branch_address = pc + immediate;

endmodule