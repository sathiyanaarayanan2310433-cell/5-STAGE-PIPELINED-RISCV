module alu(
input [2:0] alu_ctrl,
input [31:0] operand_a,
input [31:0] operand_b,
output wire zero,
output wire unsigned_less,
output wire signed_less,
output reg [31:0] alu_result
);

localparam [2:0]    ADD_OP = 3'b000,
                    SUB_OP = 3'b001,
                    AND_OP = 3'b010,
                    OR_OP  = 3'b011,
                    XOR_OP = 3'b100,
                    SLL_OP = 3'b101,
                    SLT_OP = 3'b110,
                    SRL_OP = 3'b111;

assign zero = (alu_result == 32'b0);
assign unsigned_less    = (operand_a < operand_b) ? 1'b1 : 1'b0;
assign signed_less      = ($signed(operand_a) < $signed(operand_b)) ? 1'b1 : 1'b0;  

always @(*) begin
    alu_result = operand_a + operand_b;
    case(alu_ctrl)
        ADD_OP : alu_result = operand_a + operand_b;
        SUB_OP : alu_result = operand_a - operand_b;
        AND_OP : alu_result = operand_a & operand_b;
        OR_OP  : alu_result = operand_a | operand_b;
        XOR_OP : alu_result = operand_a ^ operand_b;
        SLL_OP : alu_result = operand_a << operand_b[4:0];
        SRL_OP : alu_result = operand_a >> operand_b[4:0];
        SLT_OP : alu_result = signed_less ? 32'd1 : 32'd0;
    endcase
end

endmodule
