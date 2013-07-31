module pc_mux_test;
    reg LD_PC;
    reg [1:0]PC_SEL;
    reg [15:0]bus;
    reg [15:0]adder;
    wire [15:0]PC;

    LC3 cpu();
    PC_MUX test_pc_mux(cpu.clk, LD_PC, PC_SEL, bus, adder, PC);

    initial begin
        PC_SEL = test_pc_mux.INC;

        #5  // Wait for PC_MUX initial

        // Check initial state
        if (PC != 0) begin
            $display("PC = 0x%h, expected 0x0", PC);
        end

        // Check PC increment
        LD_PC = 1;
        #2 LD_PC = 0;
        if (PC != 2) begin
            $display("PC = 0x%h, expected 0x2", PC);
        end

        // Check set from bus
        PC_SEL = test_pc_mux.BUS;
        bus = 16'h69;
        LD_PC = 1;
        #2 LD_PC = 0;
        if (PC != 16'h69) begin
            $display("PC = 0x%h, expected 0x69", PC);
        end

        // Check set from adder
        PC_SEL = test_pc_mux.ADDER;
        adder = 16'h42;
        LD_PC = 1;
        #2 LD_PC = 0;
        if (PC != 16'h42) begin
            $display("PC = 0x%h, expected 0x42", PC);
        end

        $display("PC MUX test done");
    end
endmodule
