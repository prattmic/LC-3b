// 16-bit sign extend
// Extend __bit of __val to form a 16-bit result
`define SEXT(__val, __bit)  { {(16-__bit){__val[__bit]}}, __val }

// Address adder.  Incorporates ADDR1 and ADDR2 muxes and IR sign extension

module ADDRESS_ADDER(
    input wire clk,
    input wire [1:0]ADDR1_SEL,
    input wire [2:0]ADDR2_SEL,
    input wire LSHFT,
    input wire [15:0]IR,
    input wire [15:0]PC,
    input wire [15:0]SR1,
    output reg [15:0]OUT
);
    parameter ADDR1_PC          = 1'b0;
    parameter ADDR1_BASER       = 1'b1;

    parameter ADDR2_ZERO        = 2'h0;
    parameter ADDR2_OFFSET6     = 2'h1;
    parameter ADDR2_PCOFFSET9   = 2'h2;
    parameter ADDR2_PCOFFSET11  = 2'h3;

    wire [15:0]addr1;
    wire [15:0]addr2_noshift;
    wire [15:0]addr2;
    wire [15:0]offset6;
    wire [15:0]pc_offset9;
    wire [15:0]pc_offset11;

    assign addr1 = (ADDR1_SEL == ADDR1_PC) ? PC : SR1;

    assign offset6 = `SEXT(IR[5:0], 5);
    assign pc_offset9 = `SEXT(IR[8:0], 8);
    assign pc_offset11 = `SEXT(IR[10:0], 10);

    assign addr2_noshift = (ADDR2_SEL == ADDR2_ZERO) ? 0 :
                            (ADDR2_SEL == ADDR2_OFFSET6) ? offset6 :
                            (ADDR2_SEL == ADDR2_PCOFFSET9) ? pc_offset9 : pc_offset11;

    assign addr2 = LSHFT ? addr2_noshift << 1 : addr2_noshift;

    always @ (*) begin
        OUT <= addr1 + addr2;
    end
endmodule
