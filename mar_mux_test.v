module mar_mux_test;
    reg LD_MAR;
    reg MAR_SEL;
    reg [15:0]ir;
    reg [15:0]adder;
    wire [15:0]MAR;

    LC3 cpu();
    MAR_MUX test_mar_mux(cpu.clk, LD_MAR, MAR_SEL, ir, adder, MAR);

    initial begin
        #5  // Wait for MAR_MUX initial

        // Check initial state
        if (MAR != 0) begin
            $display("MAR = 0x%h, expected 0x0", MAR);
        end

        // Check assign from adder
        adder = 5;
        MAR_SEL = test_mar_mux.ADDER;
        LD_MAR = 1;
        #2 LD_MAR = 0;
        if (MAR != 5) begin
            $display("MAR = 0x%h, expected 0x5", MAR);
        end

        // Check assign from IR
        ir = 2; // Expect to be left shifted 1
        MAR_SEL = test_mar_mux.IR;
        LD_MAR = 1;
        #2 LD_MAR = 0;
        if (MAR != 4) begin
            $display("MAR = 0x%h, expected 0x4", MAR);
        end

        // Check assign from IR (zero extend)
        ir = 16'h1111; // Expect to cut off top byte, left shift 1
        MAR_SEL <= test_mar_mux.IR;
        LD_MAR <= 1;
        #2 LD_MAR = 0;
        if (MAR != 16'h22) begin
            $display("MAR = 0x%h, expected 0x22", MAR);
        end

        // Check assign from IR (zero extend, shift out)
        ir = 16'h1181; // Expect to cut off top byte, left shift 1
        MAR_SEL <= test_mar_mux.IR;
        LD_MAR <= 1;
        #2 LD_MAR = 0;
        if (MAR != 16'h102) begin
            $display("MAR = 0x%h, expected 0x102", MAR);
        end

        $display("MAR MUX test done");
    end
endmodule
