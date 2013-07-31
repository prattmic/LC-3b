// Condition code generation

module CC(
    input wire clk,
    input wire LD_CC,
    input wire signed [15:0]data,
    output reg N,
    output reg Z,
    output reg P
);

    initial begin
        N <= 0;
        Z <= 0;
        P <= 0;
    end

    always @ (posedge clk) begin
        if (LD_CC) begin
            N <= data < 0;
            Z <= data == 0;
            P <= data > 0;
        end
    end
endmodule
