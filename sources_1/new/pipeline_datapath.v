module pipeline_datapath(
input clk,
input rst
);

//------------------
//IF STAGE SIGNALS
//------------------

//PC
wire [31:0] pc;
wire [31:0] next_pc;

//PC_ADDER
wire [31:0] pc_plus4;

//INSTRUCTION_MEMORY
wire [31:0] instruction;

//IF_ID_REG
wire [31:0] pc_id;
wire [31:0] pc_plus4_id;
wire [31:0] instruction_id;

//------------------
//ID STAGE SIGNALS
//------------------

//INSTRUCTION_DECODER
wire [6:0] opcode;
wire [4:0] rd;
wire [4:0] rs1_id;
wire [4:0] rs2_id;
wire [2:0] funct3;
wire [6:0] funct7;

//IMMEDIATE_GENERATOR
wire [31:0] immediate;

//CONTROL_UNIT
wire RegWrite;
wire MemWrite;
wire MemRead;
wire ALUSrc_A;
wire ALUSrc_B;
wire Branch;
wire JUMP;
wire JALR;
wire [1:0] MemtoReg;
wire [1:0] ALUOp;

//REGISTER FILE
wire [31:0] read_data1;
wire [31:0] read_data2;

//ALU CONTROL UNIT
wire [2:0] alu_ctrl;

//ID EX REG
wire [31:0] pc_ex;
wire [31:0] pc_plus4_ex;
wire [4:0] rd_ex;
wire [4:0] rs1_ex;
wire [4:0] rs2_ex;
wire [2:0] funct3_ex;
wire RegWrite_ex;
wire MemWrite_ex;
wire MemRead_ex;
wire ALUSrc_A_ex;
wire ALUSrc_B_ex;
wire Branch_ex;
wire JUMP_ex;
wire JALR_ex;
wire [1:0] MemtoReg_ex;
wire [31:0] immediate_ex;
wire [31:0] read_data1_ex;
wire [31:0] read_data2_ex;
wire [2:0] alu_ctrl_ex;

//------------------
//EXE STAGE SIGNALS
//------------------

//ALU_A_MUX and ALU_B_MUX
wire [31:0] operand_a;
wire [31:0] operand_b;

//ALU
wire zero;
wire unsigned_less;
wire signed_less;
wire [31:0] alu_result;

//BRANCH_LOGIC
wire PCSrc_ex;

//BRANCH TARGET
wire [31:0] branch_address;

//JUMP_TARGET_MUX
wire [31:0] out_address;

//EX MEM REG
wire [31:0] alu_result_mem;
wire [31:0] pc_plus4_mem;
wire [4:0]  rd_mem;
wire RegWrite_mem;
wire MemRead_mem;
wire MemWrite_mem;
wire [1:0] MemtoReg_mem;
wire [31:0] immediate_mem;
wire [31:0] read_data2_mem;

//----------------------
//   MEM STAGE SIGNALS
//----------------------

//DATA MEMORY
wire [31:0] mem_read_data;

//MEM WB REG
wire [31:0] alu_result_wb;
wire [31:0] mem_data_wb;
wire [31:0] immediate_wb;
wire [31:0] pc_plus4_wb;
wire [1:0] MemtoReg_wb;
wire RegWrite_wb;
wire [4:0] rd_wb;

//----------------------
//   WB STAGE SIGNALS
//----------------------

//MEM REG MUX
wire [31:0] write_back_data;

//HAZARD UNIT SIGNALS
wire pcwrite;
wire if_id_write;
wire if_id_flush;
wire id_ex_flush;

//FORWARDING UNIT SIGNALS
wire [1:0] Forward_A;
wire [1:0] Forward_B;

//FORWARD_A_MUX
wire [31:0] forward_a_data;

//FORWARD_B_MUX
wire [31:0] forward_b_data;

//-----------------------
//      IF-STAGE
//-----------------------

assign next_pc = (PCSrc_ex) ? out_address : pc_plus4;  

pc PC(
.clk(clk),
.reset(rst),
.next_pc(next_pc),
.PCWrite(pcwrite),
.pc(pc)
);

pc_adder PC_ADDER(
.pc(pc),
.pc_plus4(pc_plus4)
);

instruction_memory INSTRUCTION_MEMORY(
.pc(pc),
.instruction(instruction)
);

if_id_reg IF_ID_REG(
.clk(clk),
.rst(rst),
.pc_if(pc),
.pc_plus4_if(pc_plus4),
.instruction_if(instruction),
.flush(if_id_flush),
.write_enable(if_id_write),
.pc_id(pc_id),
.pc_plus4_id(pc_plus4_id),
.instruction_id(instruction_id)
);

//-----------------------
//      ID-STAGE
//-----------------------

instruction_decoder INSTR_DECODER(
.instruction(instruction_id),
.opcode(opcode),
.rd(rd),
.rs1(rs1_id),
.rs2(rs2_id),
.funct3(funct3),
.funct7(funct7)
);

immediate_generator IMM_GENERATOR(
.instruction(instruction_id),
.opcode(opcode),
.immediate(immediate)
);

control_unit CTRL_UNIT(
.opcode(opcode),
.RegWrite(RegWrite),
.MemWrite(MemWrite),
.MemRead(MemRead),
.ALUSrc_A(ALUSrc_A),
.ALUSrc_B(ALUSrc_B),
.Branch(Branch),
.JUMP(JUMP),
.JALR(JALR),
.MemtoReg(MemtoReg),
.ALUOp(ALUOp)
);

register_file REG_FILE(
.clk(clk),
.write_data(write_back_data),
.write_enable(RegWrite_wb),
.rs1(rs1_id),
.rs2(rs2_id),
.rd(rd_wb),
.read_data1(read_data1),
.read_data2(read_data2)
);

alu_con ALU_CTRL(
.ALUOp(ALUOp),
.funct3(funct3),
.funct7(funct7),
.alu_ctrl(alu_ctrl)
);

id_ex_reg ID_EX_REG(
.clk(clk),
.rst(rst),
.pc_id(pc_id),
.pc_plus4_id(pc_plus4_id),
.rd_id(rd),
.rs1_id(rs1_id),
.rs2_id(rs2_id),
.funct3_id(funct3),
.RegWrite_id(RegWrite),
.MemWrite_id(MemWrite),
.MemRead_id(MemRead),
.ALUSrc_A_id(ALUSrc_A),
.ALUSrc_B_id(ALUSrc_B),
.Branch_id(Branch),
.JUMP_id(JUMP),
.JALR_id(JALR),
.MemtoReg_id(MemtoReg),
.immediate_id(immediate),
.read_data1_id(read_data1),
.read_data2_id(read_data2),
.alu_ctrl_id(alu_ctrl),

.flush(id_ex_flush),

.pc_ex(pc_ex),
.pc_plus4_ex(pc_plus4_ex),
.rd_ex(rd_ex),
.rs1_ex(rs1_ex),
.rs2_ex(rs2_ex),
.funct3_ex(funct3_ex),
.RegWrite_ex(RegWrite_ex),
.MemWrite_ex(MemWrite_ex),
.MemRead_ex(MemRead_ex),
.ALUSrc_A_ex(ALUSrc_A_ex),
.ALUSrc_B_ex(ALUSrc_B_ex),
.Branch_ex(Branch_ex),
.JUMP_ex(JUMP_ex),
.JALR_ex(JALR_ex),
.MemtoReg_ex(MemtoReg_ex),
.immediate_ex(immediate_ex),
.read_data1_ex(read_data1_ex),
.read_data2_ex(read_data2_ex),
.alu_ctrl_ex(alu_ctrl_ex)
);

//---------------
//   EXE-STAGE
//---------------

forwarding_unit FORWARD_UNIT(
.rs1_ex(rs1_ex),
.rs2_ex(rs2_ex),
.rd_mem(rd_mem),
.RegWrite_mem(RegWrite_mem),
.rd_wb(rd_wb),
.RegWrite_wb(RegWrite_wb),
.Forward_A(Forward_A),
.Forward_B(Forward_B)
);

forwardA_MUX FORWARD_A_MUX(
.read_data1(read_data1_ex),
.alu_result_mem(alu_result_mem),
.write_back_data(write_back_data),
.Forward_A(Forward_A),
.forward_a_data(forward_a_data)
);

forwardB_MUX FORWARD_B_MUX(
.read_data2(read_data2_ex),
.alu_result_mem(alu_result_mem),
.write_back_data(write_back_data),
.Forward_B(Forward_B),
.forward_b_data(forward_b_data)
);

ALUSrc_A_MUX SRC_A_MUX(
.ALUSrc_A(ALUSrc_A_ex),
.read_data1(forward_a_data),
.pc(pc_ex),
.operand_a(operand_a)
);

ALUSrc_B_MUX SRC_B_MUX(
.ALUSrc_B(ALUSrc_B_ex),
.read_data2(forward_b_data),
.immediate(immediate_ex),
.operand_b(operand_b)
);

alu ALU(
.alu_ctrl(alu_ctrl_ex),
.operand_a(operand_a),
.operand_b(operand_b),
.zero(zero),
.unsigned_less(unsigned_less),
.signed_less(signed_less),
.alu_result(alu_result)
);

branch_logic BRANCH_LOGIC(
.Branch(Branch_ex),
.funct3(funct3_ex),
.JUMP(JUMP_ex),
.zero(zero),
.signed_less(signed_less),
.unsigned_less(unsigned_less),
.PCSrc(PCSrc_ex)
);

branch_target BRANCH_TARGET(
.pc(pc_ex),
.immediate(immediate_ex),
.branch_address(branch_address)
);

jump_target_MUX JUMP_MUX(
.JALR(JALR_ex),
.branch_address(branch_address),
.alu_result(alu_result),
.out_address(out_address)
);

ex_mem_reg EX_MEM_REG(
.clk(clk),
.rst(rst),
.pc_plus4_ex(pc_plus4_ex),
.rd_ex(rd_ex),
.RegWrite_ex(RegWrite_ex),
.MemRead_ex(MemRead_ex),
.MemWrite_ex(MemWrite_ex),
.MemtoReg_ex(MemtoReg_ex),
.immediate_ex(immediate_ex),
.read_data2_ex(read_data2_ex),
.alu_result_ex(alu_result),

.pc_plus4_mem(pc_plus4_mem),
.rd_mem(rd_mem),
.RegWrite_mem(RegWrite_mem),
.MemRead_mem(MemRead_mem),
.MemWrite_mem(MemWrite_mem),
.MemtoReg_mem(MemtoReg_mem),
.immediate_mem(immediate_mem),
.alu_result_mem(alu_result_mem),.read_data2_mem(read_data2_mem));

//--------------
//  MEM STAGE
//--------------

data_memory DATA_MEM(
.clk(clk),
.alu_result(alu_result_mem),
.MemWrite(MemWrite_mem),
.MemRead(MemRead_mem),
.write_data(read_data2_mem),
.read_data(mem_read_data)
);

mem_wb_reg MEM_WB_REG(
.clk(clk),
.rst(rst),

.alu_result_mem(alu_result_mem),
.mem_data_mem(mem_read_data),
.immediate_mem(immediate_mem),
.pc_plus4_mem(pc_plus4_mem),
.MemtoReg_mem(MemtoReg_mem),
.RegWrite_mem(RegWrite_mem),
.rd_mem(rd_mem),

.alu_result_wb(alu_result_wb),
.mem_data_wb(mem_data_wb),
.immediate_wb(immediate_wb),
.pc_plus4_wb(pc_plus4_wb),
.MemtoReg_wb(MemtoReg_wb),
.RegWrite_wb(RegWrite_wb),
.rd_wb(rd_wb)
);

//--------------------
//    WB STAGE
//--------------------

MemtoReg_MUX MEM_REG_MUX(
.alu_result(alu_result_wb),
.mem_data(mem_data_wb),
.immediate(immediate_wb),
.pc_plus4(pc_plus4_wb),
.MemtoReg(MemtoReg_wb),
.write_back_data(write_back_data)
);

//--------------------
//   HAZARD HANDLING
//--------------------

hazard_unit HAZARD_UNIT(
.PCSrc_ex(PCSrc_ex),
.MemRead_ex(MemRead_ex),
.rd_ex(rd_ex),
.rs1_id(rs1_id),
.rs2_id(rs2_id),

.PCWrite(pcwrite),
.IF_ID_Write(if_id_write),
.IF_ID_Flush(if_id_flush),
.ID_EX_Flush(id_ex_flush)
);



endmodule