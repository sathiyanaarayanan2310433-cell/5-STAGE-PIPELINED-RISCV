module forwarding_unit(
input [4:0] rs1_ex,
input [4:0] rs2_ex,

input [4:0] rd_mem,
input RegWrite_mem,

input [4:0] rd_wb,
input RegWrite_wb,

output reg [1:0] Forward_A,
output reg [1:0] Forward_B
);

always @(*)
begin 
    Forward_A = 2'b00;
    Forward_B = 2'b00;

    //Forwarding rs1
    if(RegWrite_mem && (rd_mem != 5'b0) && (rd_mem == rs1_ex))
    begin 
        Forward_A = 2'b01;
    end
    else if(RegWrite_wb && (rd_wb != 5'b0) && (rd_wb == rs1_ex))
    begin 
        Forward_A = 2'b10;
    end

    //Forwarding rs2
    if(RegWrite_mem && (rd_mem != 5'b0) && (rd_mem == rs2_ex))
    begin 
        Forward_B = 2'b01;
    end
    else if(RegWrite_wb && (rd_wb != 5'b0) && (rd_wb == rs2_ex))
    begin 
        Forward_B = 2'b10;
    end

end
endmodule