module instruction_memory(
input [31:0] pc,
output wire [31:0] instruction
);

reg [31:0] memory [0:255];
integer i;

initial begin
        $readmemh("instruction.mem",memory);
end

assign instruction = memory[pc[31:2]];

endmodule