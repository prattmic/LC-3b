`define ALU_TEST(__a, __b, __add, __and, __xor) \
    A = __a;    \
    B = __b;    \
    #2          \
    if (OUT_ADD != __add)   \
        $display("0x%h + 0x%h = 0x%h, expected 0x%h", __a, __b, OUT_ADD, __add);  \
    if (OUT_AND != __and)   \
        $display("0x%h & 0x%h = 0x%h, expected 0x%h", __a, __b, OUT_AND, __and);  \
    if (OUT_XOR != __xor)   \
        $display("0x%h ^ 0x%h = 0x%h, expected 0x%h", __a, __b, OUT_XOR, __xor);

module alu_test;
    reg [15:0]A;
    reg [15:0]B;
    wire [15:0]OUT_ADD;
    wire [15:0]OUT_AND;
    wire [15:0]OUT_XOR;

    LC3 cpu();
    ALU test_add(cpu.clk, A, B, test_add.ADD, OUT_ADD);
    ALU test_and(cpu.clk, A, B, test_and.AND, OUT_AND);
    ALU test_xor(cpu.clk, A, B, test_xor.XOR, OUT_XOR);

    initial begin
        $dumpfile("alu_test.vcd");
        $dumpvars;

        `ALU_TEST(1, 1, 2, 1, 0)
        `ALU_TEST(2, 1, 3, 0, 3)
        `ALU_TEST(16'h1000, 16'h0001, 16'h1001, 0, 16'h1001)

        $finish;
    end
endmodule
