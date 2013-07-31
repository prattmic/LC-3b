// MAR MUX, includes shifting done to input
// and output MAR

module MAR_MUX(
    input wire clk,
    input wire LD_MAR,
    input wire MAR_SEL,
    input wire [15:0] ir_in,    // Input from IR
    input wire [15:0] adder,    // Input from address adder
    output reg [15:0] MAR
);
    wire [15:0]ir_byte;

    parameter IR = 1'b0;  // Byte 0 of IR
    parameter ADDER = 1'b1;    // Address adder

    initial begin
        MAR <= 0;
    end

    // Zero extend and left shift
    assign ir_byte = ir_in[7:0] << 1;

    always @ (posedge clk) begin
        if (LD_MAR) begin
            case(MAR_SEL)
                IR: MAR <= ir_byte;
                ADDER: MAR <= adder;
            endcase
        end
    end
endmodule
