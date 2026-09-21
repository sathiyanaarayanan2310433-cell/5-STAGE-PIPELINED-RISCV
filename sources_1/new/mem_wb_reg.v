module mem_wb_reg(
input clk,
input rst,

input [31:0] alu_result_mem,
input [31:0] mem_data_mem,
input [31:0] immediate_mem,
input [31:0] pc_plus4_mem,
input [1:0] MemtoReg_mem,
input RegWrite_mem,
input [4:0] rd_mem,

output reg [31:0] alu_result_wb,
output reg [31:0] mem_data_wb,
output reg [31:0] immediate_wb,
output reg [31:0] pc_plus4_wb,
output reg [1:0] MemtoReg_wb,
output reg RegWrite_wb,
output reg [4:0] rd_wb
);

always @(posedge clk)
begin 
    if(rst)
    begin 
        alu_result_wb <= 32'b0;
        mem_data_wb <= 32'b0;
        immediate_wb <= 32'b0;
        pc_plus4_wb <= 32'b0;
        MemtoReg_wb <= 2'b0;
        RegWrite_wb <= 1'b0;
        rd_wb <= 5'b0;
    end
    else
    begin 
        alu_result_wb <= alu_result_mem;
        mem_data_wb <= mem_data_mem;
        immediate_wb <= immediate_mem;
        pc_plus4_wb <= pc_plus4_mem;
        MemtoReg_wb <= MemtoReg_mem;
        RegWrite_wb <= RegWrite_mem;
        rd_wb <= rd_mem;
    end
end
endmodule