module LC3;
    reg clk;

    initial begin
        clk = 0;    // Initialize clock
    end

    always begin
        clk <= ~clk;
        #1;
    end
endmodule
