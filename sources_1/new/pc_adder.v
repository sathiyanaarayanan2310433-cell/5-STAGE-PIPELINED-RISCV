module pc_adder(
input [31:0] pc,
output wire [31:0] pc_plus4
);

assign pc_plus4 = pc + 32'd4;

endmodule