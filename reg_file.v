module REG_FILE(clk, data, LD_REG, DR, SR1, SR2, SR1_OUT, SR2_OUT);
    input wire clk;
    input wire [15:0]data;
    input wire LD_REG;
    input wire [2:0]DR;
    input wire [2:0]SR1;
    input wire [2:0]SR2;
    output reg [15:0]SR1_OUT;
    output reg [15:0]SR2_OUT;

    reg [15:0]R[0:7];

    initial begin
        R[0] <= 0;
        R[1] <= 0;
        R[2] <= 0;
        R[3] <= 0;
        R[4] <= 0;
        R[5] <= 0;
        R[6] <= 0;
        R[7] <= 0;
    end

    always @ (posedge clk) begin
        SR1_OUT <= R[SR1];
        SR2_OUT <= R[SR2];

        if (LD_REG) begin
            R[DR] <= data;
        end
    end

endmodule
