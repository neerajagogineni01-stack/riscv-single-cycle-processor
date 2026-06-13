module riscv_cpu(
    input clk,
    input reset
);

wire [31:0] pc;
wire [31:0] instruction;

wire [31:0] read_data1;
wire [31:0] read_data2;

wire [31:0] immediate;
wire [31:0] alu_result;
wire [31:0] memory_data;

wire reg_write;
wire alu_src;
wire mem_read;
wire mem_write;
wire mem_to_reg;
wire branch;

wire zero;
wire pc_src;

// Program Counter
pc PC(
    .clk(clk),
    .rst(reset),
    .pc_out(pc)
);


// Instruction Memory
instruction_memory IM(
    .addr(pc),
    .instruction(instruction)
);

// Control Unit
control_unit CU(
    .opcode(instruction[6:0]),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg),
    .branch(branch)
);

// Register File
register_file RF(
    .clk(clk),
    .reg_write(reg_write),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .write_data(mem_to_reg ? memory_data : alu_result),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// Immediate Generator
immediate_generator IG(
    .instruction(instruction),
    .immediate(immediate)
);

// ALU
alu ALU(
    .a(read_data1),
    .b(alu_src ? immediate : read_data2),
    .alu_control(3'b000),
    .result(alu_result),
    .zero(zero)
);

// Data Memory
data_memory DM(
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(alu_result),
    .write_data(read_data2),
    .read_data(memory_data)
);

// Branch Logic
branch_logic BL(
    .branch(branch),
    .zero(zero),
    .pc_src(pc_src)
);

endmodule