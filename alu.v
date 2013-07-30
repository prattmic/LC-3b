module ALU(A, B, ALUK, OUT);
    input wire [15:0]A;
    input wire [15:0]B;
    input wire [1:0]ALUK;
    output reg [15:0]OUT;

    parameter ADD = 2'd0;
    parameter AND = 2'd1;
    parameter XOR = 2'd2;
    parameter PASSA = 2'd3;

    always @ (A or B or ALUK) begin
        case(ALUK)
            ADD: OUT <= A + B;
            AND: OUT <= A & B;
            XOR: OUT <= A ^ B;
            PASSA: OUT <= A;
        endcase
    end
endmodule
