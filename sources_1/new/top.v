module top(
    input clk,
    input rst
);

//pc
wire [31:0] next_pc;
wire [31:0] pc;

//pc_adder
wire [31:0] pc_plus4;

//instruction_memory
wire [31:0] instruction;

//instruction_decoder
wire [6:0] opcode;
wire [4:0] rd;
wire [4:0] rs1;
wire [4:0] rs2;
wire [2:0] funct3;
wire [6:0] funct7;

//immediate_generator
wire [31:0] immediate;

//control_unit
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

//register_file
wire [31:0] read_data1;
wire [31:0] read_data2;

//alu_con
wire [2:0] alu_ctrl;

//ALUSrc_A_MUX
wire [31:0] operand_a;

//ALUSrc_B_MUX
wire [31:0] operand_b;

//alu
wire zero;
wire unsigned_less;
wire signed_less;
wire [31:0] alu_result;

//data_memory
wire [31:0] read_data;

//branch_logic
wire PCSrc;

//branch_target
wire [31:0] branch_address;

//jump_target_MUX
wire [31:0] out_address;

//pc_mux

//MemtoReg_MUX
wire [31:0] write_back_data;

pc PC(
.clk(clk), 
.reset(rst), 
.next_pc(next_pc), 
.pc(pc)
);

pc_adder PC_ADDER(
.pc(pc), 
.pc_plus4(pc_plus4));

instruction_memory INSTR_MEMORY(
.pc(pc),
.instruction(instruction)
);

instruction_decoder INSTR_DECODER(
.instruction(instruction),
.opcode(opcode),
.rd(rd),
.rs1(rs1),
.rs2(rs2),
.funct3(funct3),
.funct7(funct7)
);

immediate_generator IMMEDIATE_GENERATOR(
.instruction(instruction),
.opcode(opcode),
.immediate(immediate)
);

control_unit CONTROL_UNIT(
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

register_file REGISTER_FILE(
.clk(clk),
.write_data(write_back_data),
.write_enable(RegWrite),
.rs1(rs1),
.rs2(rs2),
.rd(rd),
.read_data1(read_data1),
.read_data2(read_data2)
);

ALUSrc_A_MUX ALU_A_MUX(
.ALUSrc_A(ALUSrc_A),
.read_data1(read_data1),
.pc(pc),
.operand_a(operand_a)
);

ALUSrc_B_MUX ALU_B_MUX(
.ALUSrc_B(ALUSrc_B),
.read_data2(read_data2),
.immediate(immediate),
.operand_b(operand_b)
);

alu_con ALU_CONTROL(
.ALUOp(ALUOp),
.funct3(funct3),
.funct7(funct7),
.alu_ctrl(alu_ctrl)
);

alu ALU(
.alu_ctrl(alu_ctrl),
.operand_a(operand_a),
.operand_b(operand_b),
.zero(zero),
.unsigned_less(unsigned_less),
.signed_less(signed_less),
.alu_result(alu_result)
);

data_memory DATA_MEMORY(
.clk(clk),
.alu_result(alu_result),
.MemWrite(MemWrite),
.MemRead(MemRead),
.write_data(read_data2),
.read_data(read_data)
);

branch_logic BRANCH_LOGIC(
.Branch(Branch),
.funct3(funct3),
.JUMP(JUMP),
.zero(zero),
.signed_less(signed_less),
.unsigned_less(unsigned_less),
.PCSrc(PCSrc)
);

branch_target BRANCH_TARGET(
.pc(pc),
.immediate(immediate),
.branch_address(branch_address)
);

jump_target_MUX JUMP_MUX(
.JALR(JALR),
.branch_address(branch_address),
.alu_result(alu_result),
.out_address(out_address)
);

MemtoReg_MUX MEM_TO_REG_MUX(
.alu_result(alu_result),
.mem_data(read_data),
.immediate(immediate),
.pc_plus4(pc_plus4),
.MemtoReg(MemtoReg),
.write_back_data(write_back_data)
);

pc_mux PC_MUX(
.normal_pc(pc_plus4),
.out_address(out_address),
.branch_enable(PCSrc),
.next_pc(next_pc)
);


endmodule