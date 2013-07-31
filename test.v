module test;
    initial begin
        $dumpfile("test.vcd");
        $dumpvars;

        #1000 $finish;
    end
endmodule
