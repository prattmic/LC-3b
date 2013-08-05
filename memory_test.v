module memory_test;
    reg MEM_EN;
    reg WE0;
    reg WE1;
    reg [15:0]MAR;
    reg [15:0]MDR;
    wire R;
    wire [15:0]OUT;

    LC3 cpu();
    MEMORY memory(cpu.clk, MEM_EN, WE0, WE1, MAR, MDR, R, OUT);

    initial begin
        MEM_EN = 0;
        WE0 = 0;
        WE1 = 0;
        MAR = 0;
        MDR = 16'hffff;

        // Write to 0x0
        WE0 = 1;
        WE1 = 1;
        MEM_EN = 1;
        #2 WE0 = 0;
        WE1 = 0;
        if (memory.mem[0] != 16'hffff) begin
            $display("mem[0] = 0x%h, expected 0xffff", memory.mem[0]);
        end
        if (!R) begin
            $display("Memory not ready (1)");
        end
        if (OUT != 16'hffff) begin
            $display("OUT = 0x%h, expected 0xffff (1)", OUT);
        end
        MEM_EN = 0;

        #2

        // Write upper byte of 0x1000
        MAR = 16'h1000;
        WE1 = 1;
        MEM_EN = 1;
        #2 WE1 = 0;
        if (!R) begin
            $display("Memory not ready (2)");
        end
        if (OUT != 16'hff00) begin
            $display("OUT = 0x%h, expected 0xff00", OUT);
        end
        MEM_EN = 0;

        #2

        // Read 0x0 again
        MAR = 0;
        MEM_EN = 1;
        #2 if (!R) begin
            $display("Memory not ready (3)");
        end
        if (OUT != 16'hffff) begin
            $display("OUT = 0x%h, expected 0xffff (2)", OUT);
        end
        MEM_EN = 0;

        $display("Memory test done");
    end

endmodule
