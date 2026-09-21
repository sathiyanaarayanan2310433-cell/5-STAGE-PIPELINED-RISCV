module forwardB_MUX(
input [31:0] read_data2,
input [31:0] alu_result_mem,
input [31:0] write_back_data,

input [1:0] Forward_B,

output reg [31:0] forward_b_data
);

always @(*)
begin 
    case(Forward_B)
        2'b00 : forward_b_data = read_data2;
        2'b01 : forward_b_data = alu_result_mem;
        2'b10 : forward_b_data = write_back_data;
        default : forward_b_data = read_data2;
    endcase
end

endmodule