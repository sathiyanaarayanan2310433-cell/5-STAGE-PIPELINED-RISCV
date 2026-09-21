    module data_memory(
input clk,
input [31:0] alu_result,
input MemWrite,
input MemRead,
input [31:0] write_data,
output wire [31:0] read_data
);

reg [31:0] d_memory [0:255];
integer i;

initial begin
    for(i = 0; i < 256 ; i = i + 1)
        d_memory[i] = 32'b0;
end

assign read_data = (MemRead) ? d_memory[alu_result[31:2]] : 32'b0;

always @(posedge clk) begin
    if(MemWrite)
        d_memory[alu_result[31:2]] <= write_data; 
end

endmodule