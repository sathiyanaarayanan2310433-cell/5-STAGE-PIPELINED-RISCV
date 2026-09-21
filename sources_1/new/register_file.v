module register_file(
input clk,
input [31:0] write_data,
input write_enable,
input [4:0] rs1,
input [4:0] rs2,
input [4:0] rd,
output wire [31:0] read_data1,
output wire [31:0] read_data2
);

reg [31:0] registers [0:31];

integer i;
initial begin
    for(i = 0; i < 32 ; i = i + 1)
        registers[i] = 32'b0;
end

assign read_data1 = (write_enable && (rd != 5'b0) && (rd == rs1)) ? write_data : registers[rs1];
assign read_data2 = (write_enable && (rd != 5'b0) && (rd == rs2)) ? write_data : registers[rs2];

always @(posedge clk) 
begin

    if(write_enable && rd != 5'b0)
    begin
        registers[rd] <= write_data;
    end

end

endmodule