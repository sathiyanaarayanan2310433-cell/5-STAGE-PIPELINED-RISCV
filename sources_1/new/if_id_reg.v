module if_id_reg(
input clk,
input rst,

input [31:0] pc_if,
input [31:0] pc_plus4_if,
input [31:0] instruction_if,

input flush,
input write_enable,

output reg [31:0] pc_id,
output reg [31:0] pc_plus4_id,
output reg [31:0] instruction_id
);

always @(posedge clk)
begin
    if(rst) 
    begin
        pc_id <= 32'b0;
        pc_plus4_id <= 32'b0;
        instruction_id <= 32'h00000013;
    end
    else if(flush)
    begin 
        pc_id <= 32'b0;
        pc_plus4_id <= 32'b0;
        instruction_id <= 32'h00000013;
    end
    else if(write_enable)
    begin
        pc_id <= pc_if;
        pc_plus4_id <= pc_plus4_if;
        instruction_id <= instruction_if;
    end
end

endmodule