module address_adder_test;
    reg [1:0]ADDR1_SEL;
    reg [2:0]ADDR2_SEL;
    reg LSHFT;
    reg signed [15:0]IR;
    reg [15:0]PC;
    reg [15:0]SR1;
    wire [15:0]OUT;

    ADDRESS_ADDER test_address_adder(ADDR1_SEL, ADDR2_SEL, LSHFT, IR, PC, SR1, OUT);

    initial begin
        // Check PC + 0
        PC = 5;
        ADDR1_SEL = test_address_adder.ADDR1_PC;
        ADDR2_SEL = test_address_adder.ADDR2_ZERO;
        LSHFT = 0;
        if (OUT != 5) begin
            $display("OUT = 0x%h, expected 0x5", OUT);
        end

        // Check PC + IR[5:0]
        PC = 5;
        IR = 16'h1111;
        ADDR1_SEL = test_address_adder.ADDR1_PC;
        ADDR2_SEL = test_address_adder.ADDR2_OFFSET6;
        LSHFT = 0;
        #2 if (OUT != 16'h16) begin
            $display("OUT = 0x%h, expected 0x16", OUT);
        end

        // Check PC + IR[5:0], with sign extension
        PC = 5;
        IR = -1;
        ADDR1_SEL = test_address_adder.ADDR1_PC;
        ADDR2_SEL = test_address_adder.ADDR2_OFFSET6;
        LSHFT = 0;
        #2 if (OUT != 16'h4) begin
            $display("OUT = 0x%h, expected 0x4", OUT);
        end

        // Check PC + IR[8:0]
        PC = 5;
        IR = 16'h1011;
        ADDR1_SEL = test_address_adder.ADDR1_PC;
        ADDR2_SEL = test_address_adder.ADDR2_PCOFFSET9;
        LSHFT = 0;
        #2 if (OUT != 16'h16) begin
            $display("OUT = 0x%h, expected 0x16", OUT);
        end

        // Check PC + IR[8:0], with sign extension
        PC = 256;
        IR = -255;
        ADDR1_SEL = test_address_adder.ADDR1_PC;
        ADDR2_SEL = test_address_adder.ADDR2_PCOFFSET9;
        LSHFT = 0;
        #2 if (OUT != 16'h1) begin
            $display("OUT = 0x%h, expected 0x1", OUT);
        end

        // Check PC + IR[10:0]
        PC = 5;
        IR = 16'h1111;
        ADDR1_SEL = test_address_adder.ADDR1_PC;
        ADDR2_SEL = test_address_adder.ADDR2_PCOFFSET11;
        LSHFT = 0;
        #2 if (OUT != 16'h116) begin
            $display("OUT = 0x%h, expected 0x116", OUT);
        end

        // Check PC + IR[10:0], with sign extension
        PC = 200;
        IR = -100;
        ADDR1_SEL = test_address_adder.ADDR1_PC;
        ADDR2_SEL = test_address_adder.ADDR2_PCOFFSET11;
        LSHFT = 0;
        #2 if (OUT != 16'd100) begin
            $display("OUT = %d, expected 100", OUT);
        end

        // Check BASER + IR[10:0], with left shift
        SR1 = 16'h40;
        IR = 16'h10;
        ADDR1_SEL = test_address_adder.ADDR1_BASER;
        ADDR2_SEL = test_address_adder.ADDR2_PCOFFSET11;
        LSHFT = 1;
        #2 if (OUT != 16'h60) begin
            $display("OUT = 0x%h, expected 0x60", OUT);
        end

        // Check BASER + IR[10:0], with left shift and sign extend
        SR1 = 16'h40;
        IR = -1;
        ADDR1_SEL = test_address_adder.ADDR1_BASER;
        ADDR2_SEL = test_address_adder.ADDR2_PCOFFSET11;
        LSHFT = 1;
        #2 if (OUT != 16'h3e) begin
            $display("OUT = 0x%h, expected 0x3e", OUT);
        end

        $display("Address adder test done");
    end
endmodule
