module hazard_unit(
input PCSrc_ex,
input MemRead_ex,
input [4:0] rd_ex,
input [4:0] rs1_id,
input [4:0] rs2_id,

output reg PCWrite,
output reg IF_ID_Write,
output reg IF_ID_Flush,
output reg ID_EX_Flush
);

always @(*)
begin

    PCWrite     = 1'b1;
    ID_EX_Flush = 1'b0;
    IF_ID_Flush = 1'b0;
    IF_ID_Write = 1'b1;

    if (MemRead_ex && ((rd_ex == rs1_id) || (rd_ex == rs2_id)) && (rd_ex != 5'b0))
    begin 
        PCWrite     = 1'b0;
        IF_ID_Write = 1'b0;
        IF_ID_Flush = 1'b0;
        ID_EX_Flush = 1'b1;
    end
    else if (PCSrc_ex)
    begin 
        IF_ID_Flush = 1'b1;
        ID_EX_Flush = 1'b1;
    end
end


endmodule