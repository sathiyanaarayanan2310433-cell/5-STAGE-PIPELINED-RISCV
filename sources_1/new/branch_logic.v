module branch_logic(
input Branch,
input [2:0] funct3,
input JUMP,
input zero,
input signed_less,
input unsigned_less,
output reg PCSrc
);

always @(*) begin
    PCSrc = 1'b0;
    if (JUMP) 
        PCSrc = 1'b1;
    else if(Branch) begin
        case(funct3)
            3'b000 : PCSrc = (zero) ? 1'b1 : 1'b0; //BEQ
            3'b001 : PCSrc = (!zero) ? 1'b1 : 1'b0; //BNEQ
            3'b100 : PCSrc = (signed_less) ? 1'b1 : 1'b0; //BLT
            3'b101 : PCSrc = (!signed_less) ? 1'b1 : 1'b0; //BGE
            3'b110 : PCSrc = (unsigned_less) ? 1'b1 : 1'b0; //BLTU
            3'b111 : PCSrc = (!unsigned_less) ? 1'b1 : 1'b0; //BGEU
            default : PCSrc = 1'b0;
        endcase
    end
end

endmodule