module ALU(clk, A, B, ALUK, OUT);
    input wire clk;
    input wire [15:0]A;
    input wire [15:0]B;
    input wire [1:0]ALUK;
    output reg [15:0]OUT;

    parameter ADD = 2'd0;
    parameter AND = 2'd1;
    parameter XOR = 2'd2;
    parameter PASS = 2'd3;

    always @ (posedge clk) begin
        case(ALUK)
            ADD: OUT <= A + B;
            AND: OUT <= A & B;
            XOR: OUT <= A ^ B;
            PASS: OUT <= A;     // Which input am I supposed to pass?
        endcase
    end
endmodule
