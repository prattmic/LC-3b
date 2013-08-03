module SHIFTER(
    input wire [5:0]IR6,
    input wire [15:0]SR1,
    output reg [15:0]OUT
);
    wire [1:0]type;
    wire [3:0]amount;

    parameter LEFT_SHIFT = 2'b00;
    parameter LOGICAL_RIGHT_SHIFT = 2'b01;
    parameter ARITHMETIC_RIGHT_SHIFT = 2'b11;

    initial begin
        OUT <= 0;
    end

    assign type = IR6[5:4];
    assign amount = IR6[3:0];

    always @ (type or amount or SR1) begin
        case(type)
            LEFT_SHIFT: OUT <= SR1 << amount;
            LOGICAL_RIGHT_SHIFT: OUT <= SR1 >> amount;
            ARITHMETIC_RIGHT_SHIFT: OUT <= $signed(SR1) >>> amount;
            default: OUT <= 16'hxxxx;   // Invalid type
        endcase
    end
endmodule
