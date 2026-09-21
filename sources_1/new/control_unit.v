module  control_unit(
input [6:0] opcode,
output reg RegWrite,
output reg MemWrite,
output reg MemRead,
output reg ALUSrc_A,
output reg ALUSrc_B,
output reg Branch,
output reg JUMP,
output reg JALR,
output reg [1:0] MemtoReg,
output reg [1:0] ALUOp
);

always @(*) begin
    RegWrite    = 1'b0;
    MemWrite    = 1'b0;
    MemRead     = 1'b0;
    ALUSrc_A    = 1'b0;
    ALUSrc_B    = 1'b0;
    Branch      = 1'b0;
    JUMP        = 1'b0;
    JALR        = 1'b0;
    MemtoReg    = 2'b00;
    ALUOp       = 2'b00;
    case(opcode)

        7'b0110011 : //R-type
        begin
            RegWrite    = 1'b1;
            MemtoReg    = 2'b00;
            ALUOp       = 2'b01;
        end
        7'b0010011 : //I-type
        begin
            RegWrite    = 1'b1;
            ALUSrc_B    = 1'b1;
            MemtoReg    = 2'b00;
            ALUOp       = 2'b01;
        end

        7'b0000011 : //Load
        begin
            RegWrite    = 1'b1;
            MemRead     = 1'b1;
            ALUSrc_B    = 1'b1;
            MemtoReg    = 2'b01;
            ALUOp       = 2'b00;
        end
        
        7'b0100011 : //S-type
        begin
            MemWrite    = 1'b1;
            ALUSrc_B    = 1'b1;
            ALUOp       = 2'b00;
        end

        7'b1100011 : //B-type
        begin
            Branch      = 1'b1;
            ALUOp       = 2'b10;
        end

        7'b1101111 : //JAL
        begin
            RegWrite    = 1'b1;
            JUMP        = 1'b1;
            ALUSrc_A    = 1'b1;
            ALUSrc_B    = 1'b1;
            MemtoReg    = 2'b10;
        end

        7'b1100111 : //JALR
        begin
            RegWrite    = 1'b1;
            JALR        = 1'b1;
            JUMP        = 1'b1;
            ALUSrc_B    = 1'b1;
            MemtoReg    = 2'b10;
            ALUOp       = 2'b00;
        end

        7'b0010111 : //AUIPC
        begin
            RegWrite    = 1'b1;
            ALUSrc_A    = 1'b1;
            ALUSrc_B    = 1'b1;
            MemtoReg    = 2'b00;
            ALUOp       = 2'b00;
        end

        7'b0110111 : //LUI
        begin
            RegWrite    = 1'b1;
            MemtoReg    = 2'b11;
        end
    endcase
end



endmodule