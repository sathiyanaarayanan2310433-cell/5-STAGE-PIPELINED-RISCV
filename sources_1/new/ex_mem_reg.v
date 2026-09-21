module ex_mem_reg(
input clk,
input rst,

input [31:0] alu_result_ex,
input [31:0] pc_plus4_ex,
input [4:0] rd_ex,
input RegWrite_ex,
input MemRead_ex,
input MemWrite_ex,
input [1:0] MemtoReg_ex,
input [31:0] immediate_ex,
input [31:0] read_data2_ex,

output reg [31:0] alu_result_mem,
output reg [31:0] pc_plus4_mem,
output reg [4:0] rd_mem,
output reg RegWrite_mem,
output reg MemRead_mem,
output reg MemWrite_mem,
output reg [1:0] MemtoReg_mem,
output reg [31:0] immediate_mem,
output reg [31:0] read_data2_mem
);

always @(posedge clk)
begin 
    if(rst)
    begin 
        alu_result_mem <= 32'b0;
        pc_plus4_mem <= 32'b0;
        rd_mem <= 5'b0;
        RegWrite_mem <= 1'b0;
        MemRead_mem <= 1'b0;
        MemWrite_mem <= 1'b0;
        MemtoReg_mem <= 2'b0;
        immediate_mem <= 32'b0;
        read_data2_mem <= 32'b0;
    end
    else
    begin 
        alu_result_mem <= alu_result_ex;
        pc_plus4_mem <= pc_plus4_ex;
        rd_mem <= rd_ex;
        RegWrite_mem <= RegWrite_ex;
        MemRead_mem <= MemRead_ex;
        MemWrite_mem <= MemWrite_ex;
        MemtoReg_mem <= MemtoReg_ex;
        immediate_mem <= immediate_ex;
        read_data2_mem <= read_data2_ex;
    end
end


endmodule