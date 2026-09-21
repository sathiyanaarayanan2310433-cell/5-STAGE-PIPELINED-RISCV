module MemtoReg_MUX(
input [31:0] alu_result,
input [31:0] mem_data,
input [31:0] immediate,
input [31:0] pc_plus4,
input [1:0] MemtoReg,
output reg [31:0] write_back_data
);

always @(*) begin
    write_back_data = 32'b0;
    case(MemtoReg)
        2'b00 : write_back_data = alu_result;
        2'b01 : write_back_data = mem_data;
        2'b10 : write_back_data = pc_plus4;
        2'b11 : write_back_data = immediate;
        default : write_back_data = 32'b0;
    endcase
end

endmodule