module  ALUSrc_B_MUX(
input ALUSrc_B,
input [31:0] read_data2,
input [31:0] immediate,
output wire [31:0] operand_b
);

assign operand_b = (ALUSrc_B) ? immediate : read_data2;

endmodule