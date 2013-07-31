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

        $display("Register file test done");
    end
endmodule
