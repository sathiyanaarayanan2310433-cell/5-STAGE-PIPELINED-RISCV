module alu_con(
input [1:0] ALUOp,
input [2:0] funct3,
input [6:0] funct7,
output reg [2:0] alu_ctrl
);

localparam [2:0]    ADD_OP = 3'b000,
                    SUB_OP = 3'b001,
                    AND_OP = 3'b010,
                    OR_OP  = 3'b011,
                    XOR_OP = 3'b100,
                    SLL_OP = 3'b101,
                    SLT_OP = 3'b110,
                    SRL_OP = 3'b111;

always @(*) begin
    alu_ctrl = ADD_OP;
    case(ALUOp)
        2'b00 : alu_ctrl = ADD_OP;
        2'b01 :
        begin
            case(funct7)
                7'b0000000 :
                begin
                    case(funct3)
                        3'b000 : alu_ctrl = ADD_OP;
                        3'b001 : alu_ctrl = SLL_OP;
                        3'b010 : alu_ctrl = SLT_OP;
                        3'b100 : alu_ctrl = XOR_OP;
                        3'b101 : alu_ctrl = SRL_OP;
                        3'b110 : alu_ctrl = OR_OP;
                        3'b111 : alu_ctrl = AND_OP;
                    endcase
                end
                7'b0100000 : if(funct3 == 3'b000) alu_ctrl = SUB_OP;
            endcase
        end
        2'b10 : alu_ctrl = SUB_OP;
    endcase
end

endmodule