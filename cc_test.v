module cc_test;
    reg LD_CC;
    reg signed [15:0]data;
    wire N;
    wire Z;
    wire P;

    LC3 cpu();
    CC test_cc(cpu.clk, LD_CC, data, N, Z, P);

    initial begin
        #5  // Wait for CC initial

        // Check initial state
        if (N != 0 || Z != 0 || P != 0) begin
            $display("N = %d, Z = %d, P = %d, expected 0, 0, 0", N, Z, P);
        end

        // Check negative
        data = -5;
        LD_CC = 1;
        #2 LD_CC = 0;
        if (N != 1 || Z != 0 || P != 0) begin
            $display("N = %d, Z = %d, P = %d, expected 1, 0, 0", N, Z, P);
        end

        // Check zero
        data = 0;
        LD_CC = 1;
        #2 LD_CC = 0;
        if (N != 0 || Z != 1 || P != 0) begin
            $display("N = %d, Z = %d, P = %d, expected 0, 1, 0", N, Z, P);
        end

        // Check positive
        data = 5;
        LD_CC = 1;
        #2 LD_CC = 0;
        if (N != 0 || Z != 0 || P != 1) begin
            $display("N = %d, Z = %d, P = %d, expected 0, 0, 1", N, Z, P);
        end

        $display("CC test done");
    end
endmodule
