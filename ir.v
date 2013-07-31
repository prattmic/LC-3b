module IR(
    input wire clk,
    input wire LD_IR,
    input wire [15:0]data,
    output reg [15:0]IR
);

    initial begin
        IR <= 0;
    end

    always @ (posedge clk) begin
        if (LD_IR) begin
            IR <= data;
        end
    end
endmodule
