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
    end
endmodule

module reg_file_test;
    reg [15:0]data;
    reg LD_REG;
    reg [2:0]DR;
    reg [2:0]SR1;
    reg [2:0]SR2;
    wire [15:0]SR1_OUT;
    wire [15:0]SR2_OUT;

    LC3 cpu();
    REG_FILE test_reg_file(cpu.clk, data, LD_REG, DR, SR1, SR2, SR1_OUT, SR2_OUT);

    initial begin
        // Wait for registers to zero
        #5

        // Test setting and reading register
        data = 16'h69;
        DR = 3;
        LD_REG = 1;
        #2 LD_REG = 0;

        SR1 = 3;
        #2 if (SR1_OUT != 16'h69) begin
            $display("SR1_OUT = 0x%h, expected 0x%h", SR1_OUT, 16'h69);
        end
    end
endmodule

module test;
    initial begin
        $dumpfile("test.vcd");
        $dumpvars;

        #1000 $finish;
    end
endmodule
