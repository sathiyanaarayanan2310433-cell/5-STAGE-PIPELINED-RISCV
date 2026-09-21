module forwardA_MUX(
input [31:0] read_data1,
input [31:0] alu_result_mem,
input [31:0] write_back_data,

input [1:0] Forward_A,

output reg [31:0] forward_a_data
);

always @(*)
begin 
    case(Forward_A)
        2'b00 : forward_a_data = read_data1;
        2'b01 : forward_a_data = alu_result_mem;
        2'b10 : forward_a_data = write_back_data;
        default : forward_a_data = read_data1;
    endcase
end

endmodule