module mdr_test;
    reg MIO_EN;
    reg LD_MDR;
    reg DATA_SIZE;
    reg [15:0]databus;
    reg [15:0]inmux_data;
    reg [15:0]MAR;
    wire [15:0]MDR;

    LC3 cpu();
    MDR_STORE test_mdr(cpu.clk, MIO_EN, LD_MDR, DATA_SIZE, databus, inmux_data, MAR, MDR);

    initial begin
        MIO_EN <= 0;
        LD_MDR <= 0;
        DATA_SIZE <= test_mdr.DATA_WORD;
        MAR <= 0;

        #5  // Wait for MDR initial

        // Test basic databus load
        MIO_EN = 0;
        databus = 16'h1111;
        LD_MDR = 1;
        #2 LD_MDR = 0;
        if (MDR != 16'h1111) begin
            $display("MDR = 0x%h, expected 0x1111", MDR);
        end

        #1

        // Test basic inmux load
        MIO_EN = 1;
        inmux_data = 16'h2222;
        LD_MDR = 1;
        #2 LD_MDR = 0;
        if (MDR != 16'h2222) begin
            $display("MDR = 0x%h, expected 0x2222", MDR);
        end

        #1

        // Test load of lower byte
        MIO_EN = 0;
        MAR = 0;
        DATA_SIZE = test_mdr.DATA_BYTE;
        databus = 16'h3333;
        LD_MDR = 1;
        #2 LD_MDR = 0;
        if (MDR != 16'h0033) begin
            $display("MDR = 0x%h, expected 0x0033", MDR);
        end

        #1

        // Test load and read of upper byte
        MIO_EN = 0;
        MAR = 1;
        DATA_SIZE = test_mdr.DATA_BYTE;
        databus = 16'h3333;
        LD_MDR = 1;
        #2 LD_MDR = 0;
        // Byte stored at proper alignment
        if (test_mdr.real_mdr != 16'h3300) begin
            $display("real_mdr = 0x%h, expected 0x3300", test_mdr.real_mdr);
        end
        if (MDR != 16'h0033) begin  // MDR reads out byte at LSB
            $display("MDR = 0x%h, expected 0x0033", MDR);
        end

        #1

        // Test read of upper byte
        MIO_EN = 1;
        MAR = 1;
        DATA_SIZE = test_mdr.DATA_BYTE;
        inmux_data = 16'h4444;
        LD_MDR = 1;
        #2 LD_MDR = 0;
        // Data size doesn't affect inmux_data storage
        if (test_mdr.real_mdr != 16'h4444) begin
            $display("real_mdr = 0x%h, expected 0x4444", test_mdr.real_mdr);
        end
        if (MDR != 16'h0044) begin  // MDR reads out byte at LSB
            $display("MDR = 0x%h, expected 0x0044", MDR);
        end

        $display("MDR test done");
    end

endmodule
