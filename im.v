module instruction_memory(
input [31:0] addr,
output [31:0] instruction
);

reg [31:0] mem [0:255];

initial begin
mem[0] = 32'h002081B3; // add x3,x1,x2
mem[1] = 32'h40118233; // sub x4,x3,x1
mem[2] = 32'h002272B3; // and x5,x4,x2
mem[3] = 32'h0012E333; // or x6,x5,x1
end

assign instruction = mem[addr[31:2]];

endmodule