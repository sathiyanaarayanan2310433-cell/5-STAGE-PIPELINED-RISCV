module immediate_generator(
input [31:0] instruction,
input [6:0] opcode,
output reg [31:0] immediate
);

always @(*) begin
    immediate = 32'b0;
    case(opcode)
        7'b0010011 , 
        7'b0000011,
        7'b1100111 : immediate = {{20{instruction[31]}},instruction[31:20]}; //I-type- ARITHM, LOAD, JALR 
        7'b0100011 : immediate = {{20{instruction[31]}},instruction[31:25],instruction[11:7]}; //S-type
        7'b1100011 : immediate = {{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0}; //B-type
        7'b0110111,
        7'b0010111 : immediate = {instruction[31:12],12'b0}; //U-type
        7'b1101111 : immediate = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}; // JAL
        default    : immediate = 32'b0;
    endcase
end

endmodule