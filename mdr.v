`include "sign.vh"

// MDR Logic
// Handles store of MDR, as well as input and output logic

module MDR_STORE(
    input wire clk,
    input wire MIO_EN,
    input wire LD_MDR,
    input wire DATA_SIZE,
    input wire [15:0]databus_in,
    input wire [15:0]inmux_in,
    input wire [15:0]MAR,
    output wire [15:0]MDR
);
    wire [15:0]data_in_byte;
    wire [15:0]data_in;
    wire [15:0]data_out_byte;
    wire [15:0]mdr_in;
    reg [15:0]real_mdr;

    parameter DATA_WORD = 1'b0;
    parameter DATA_BYTE = 1'b1;

    initial begin
        real_mdr <= 0;
    end

    // The byte we can about is loaded into MDR aligned properly
    assign data_in_byte = MAR[0] ? databus_in[15:8] << 8 : databus_in[7:0];
    assign data_in = (DATA_SIZE == DATA_WORD) ? databus_in : data_in_byte;
    assign mdr_in = MIO_EN ? inmux_in : data_in;

    // Sign-extended byte of MDR
    assign data_out_byte = MAR[0] ? `SEXT(real_mdr[15:8], 7) : `SEXT(real_mdr[7:0], 7);
    assign MDR = (DATA_SIZE == DATA_WORD) ? real_mdr : data_out_byte;

    always @ (posedge clk) begin
        if (LD_MDR) begin
            real_mdr <= mdr_in;
        end
    end
endmodule
