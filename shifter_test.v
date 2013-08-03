`define SHIFTER_TEST(__a, __type, __amount, __expected) \
    A = __a;            \
    type = __type;      \
    amount = __amount;  \
    #2                  \
    if (OUT != __expected)   \
        $display("0x%h (shift type %b) 0x%h = 0x%h, expected 0x%h (IR6 = 0x%h)", \
                 __a, __type, __amount, OUT, __expected, IR6);

module shifter_test;
    reg [15:0]A;
    reg [1:0]type;
    reg [3:0]amount;
    wire [15:0]OUT;

    wire [5:0]IR6;

    SHIFTER test_shifter(IR6, A, OUT);

    assign IR6 = (type << 4) | amount;

    initial begin
        `SHIFTER_TEST(16'd4, test_shifter.LEFT_SHIFT, 1, 16'd8)
        `SHIFTER_TEST(16'd1, test_shifter.LOGICAL_RIGHT_SHIFT, 1, 16'd0)
        `SHIFTER_TEST(16'hffff, test_shifter.LOGICAL_RIGHT_SHIFT, 1, 16'h7fff)
        `SHIFTER_TEST(-16'd2, test_shifter.ARITHMETIC_RIGHT_SHIFT, 1, -16'd1)

        $display("Shifter test done");
    end
endmodule
