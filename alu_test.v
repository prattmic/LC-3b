`define ALU_TEST(__a, __b, __add, __and, __xor, __passa) \
    A = __a;    \
    B = __b;    \
    #2          \
    if (OUT_ADD != __add)   \
        $display("0x%h + 0x%h = 0x%h, expected 0x%h", __a, __b, OUT_ADD, __add);  \
    if (OUT_AND != __and)   \
        $display("0x%h & 0x%h = 0x%h, expected 0x%h", __a, __b, OUT_AND, __and);  \
    if (OUT_XOR != __xor)   \
        $display("0x%h ^ 0x%h = 0x%h, expected 0x%h", __a, __b, OUT_XOR, __xor);  \
    if (OUT_PASSA != __passa)   \
        $display("0x%h = 0x%h, expected 0x%h", __a, __b, OUT_PASSA, __passa);

module alu_test;
    reg [15:0]A;
    reg [15:0]B;
    wire [15:0]OUT_ADD;
    wire [15:0]OUT_AND;
    wire [15:0]OUT_XOR;
    wire [15:0]OUT_PASSA;

    ALU test_add(A, B, test_add.ADD, OUT_ADD);
    ALU test_and(A, B, test_and.AND, OUT_AND);
    ALU test_xor(A, B, test_xor.XOR, OUT_XOR);
    ALU test_passa(A, B, test_xor.PASSA, OUT_PASSA);

    initial begin
        `ALU_TEST(1, 1, 2, 1, 0, 1)
        `ALU_TEST(2, 1, 3, 0, 3, 2)
        `ALU_TEST(16'h1000, 16'h0001, 16'h1001, 0, 16'h1001, 16'h1000)
        $display("ALU test done");
    end
endmodule
