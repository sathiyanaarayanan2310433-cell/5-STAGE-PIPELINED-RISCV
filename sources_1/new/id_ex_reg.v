module id_ex_reg(
input clk,
input rst,

input [31:0] pc_id,
input [31:0] pc_plus4_id,
input [4:0] rd_id,
input [4:0] rs1_id,
input [4:0] rs2_id,
input [2:0] funct3_id,
input RegWrite_id,
input MemWrite_id,
input MemRead_id,
input ALUSrc_A_id,
input ALUSrc_B_id,
input Branch_id,
input JUMP_id,
input JALR_id,
input [1:0]  MemtoReg_id,
input [31:0] immediate_id,
input [31:0] read_data1_id,
input [31:0] read_data2_id,
input [2:0]  alu_ctrl_id,

input flush,

output reg [31:0] pc_ex,
output reg [31:0] pc_plus4_ex,
output reg [4:0] rd_ex,
output reg [4:0] rs1_ex,
output reg [4:0] rs2_ex,
output reg [2:0] funct3_ex,
output reg RegWrite_ex,
output reg MemWrite_ex,
output reg MemRead_ex,
output reg ALUSrc_A_ex,
output reg ALUSrc_B_ex,
output reg Branch_ex,
output reg JUMP_ex,
output reg JALR_ex,
output reg [1:0]  MemtoReg_ex,
output reg [31:0] immediate_ex,
output reg [31:0] read_data1_ex,
output reg [31:0] read_data2_ex,
output reg [2:0]  alu_ctrl_ex

);

always @(posedge clk)
begin
    if(rst)
    begin
        pc_ex          <= 32'b0;
        pc_plus4_ex    <= 32'b0;
        rd_ex          <= 5'b0;
        rs1_ex         <= 5'b0;
        rs2_ex         <= 5'b0;
        funct3_ex      <= 3'b0;
        immediate_ex   <= 32'b0;
        read_data1_ex  <= 32'b0;
        read_data2_ex  <= 32'b0;
        alu_ctrl_ex    <= 3'b000;
        RegWrite_ex    <= 1'b0;
        MemWrite_ex    <= 1'b0;
        MemRead_ex     <= 1'b0;
        ALUSrc_A_ex    <= 1'b0;
        ALUSrc_B_ex    <= 1'b0;
        Branch_ex      <= 1'b0;
        JUMP_ex        <= 1'b0;
        JALR_ex        <= 1'b0;
        MemtoReg_ex    <= 2'b00;
    end
    else if(flush)
    begin 
        pc_ex          <= 32'b0;
        pc_plus4_ex    <= 32'b0;
        rd_ex          <= 5'b0;
        rs1_ex         <= 5'b0;
        rs2_ex         <= 5'b0;
        funct3_ex      <= 3'b0;
        immediate_ex   <= 32'b0;
        read_data1_ex  <= 32'b0;
        read_data2_ex  <= 32'b0;
        alu_ctrl_ex    <= 3'b000;
        RegWrite_ex    <= 1'b0;
        MemWrite_ex    <= 1'b0;
        MemRead_ex     <= 1'b0;
        ALUSrc_A_ex    <= 1'b0;
        ALUSrc_B_ex    <= 1'b0;
        Branch_ex      <= 1'b0;
        JUMP_ex        <= 1'b0;
        JALR_ex        <= 1'b0;
        MemtoReg_ex    <= 2'b00;
    end
    else
    begin 
        pc_ex <= pc_id;
        pc_plus4_ex <= pc_plus4_id;
        rd_ex <= rd_id;
        rs1_ex <= rs1_id;
        rs2_ex <= rs2_id;
        funct3_ex <= funct3_id;
        RegWrite_ex <= RegWrite_id;
        MemWrite_ex <= MemWrite_id;
        MemRead_ex <= MemRead_id;
        ALUSrc_A_ex <= ALUSrc_A_id;
        ALUSrc_B_ex <= ALUSrc_B_id;
        Branch_ex <= Branch_id;
        JUMP_ex <= JUMP_id;
        JALR_ex <= JALR_id;
        MemtoReg_ex <= MemtoReg_id;
        immediate_ex <= immediate_id;
        read_data1_ex <= read_data1_id;
        read_data2_ex <= read_data2_id;
        alu_ctrl_ex <= alu_ctrl_id;
    end
end

endmodule