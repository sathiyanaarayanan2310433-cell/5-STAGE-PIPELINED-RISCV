module pc(
input clk,reset,
input [31:0] next_pc,

input PCWrite,

output reg [31:0] pc
);

always @(posedge clk) 
begin
    if(reset)
        pc <= 32'b0;
    else if(PCWrite)
        pc <= next_pc;
end

endmodule