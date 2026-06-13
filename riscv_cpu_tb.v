`timescale 1ns/1ps

module riscv_cpu_tb;

reg clk;
reg reset;

riscv_cpu uut(
    .clk(clk),
    .reset(reset)
);

// Clock generation
always #5 clk = ~clk;

// VCD generation
initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0, riscv_cpu_tb);
end

initial begin

    clk = 0;
    reset = 1;

    #10;
    reset = 0;

    #100;

    $finish;

end

endmodule