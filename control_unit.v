module control_unit(
    input [6:0] opcode,

    output reg reg_write,
    output reg alu_src,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg branch
);

always @(*) begin

    // Default values
    reg_write = 0;
    alu_src   = 0;
    mem_read  = 0;
    mem_write = 0;
    mem_to_reg= 0;
    branch    = 0;

    case(opcode)

        7'b0110011: begin   // R-Type
            reg_write = 1;
            alu_src   = 0;
        end

        7'b0010011: begin   // I-Type (ADDI)
            reg_write = 1;
            alu_src   = 1;
        end

        7'b0000011: begin   // Load (LW)
            reg_write = 1;
            alu_src   = 1;
            mem_read  = 1;
            mem_to_reg= 1;
        end

        7'b0100011: begin   // Store (SW)
            alu_src   = 1;
            mem_write = 1;
        end

        7'b1100011: begin   // Branch (BEQ)
            branch    = 1;
        end

    endcase

end

endmodule