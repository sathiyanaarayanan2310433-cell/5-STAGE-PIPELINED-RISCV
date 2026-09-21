module jump_target_MUX(
input JALR,
input [31:0] branch_address,
input [31:0] alu_result,
output wire[31:0] out_address
);

assign out_address = (JALR) ? {alu_result[31:1], 1'b0} : branch_address; 

endmodule