module  ALUSrc_A_MUX(
input ALUSrc_A,
input [31:0] read_data1,
input [31:0] pc,
output wire [31:0] operand_a
);

assign operand_a = (ALUSrc_A) ? pc : read_data1;

endmodule