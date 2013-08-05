module MEMORY(
    input wire clk,
    input wire MEM_EN,
    input wire WE0,
    input wire WE1,
    input wire [15:0]MAR,
    input wire [15:0]MDR,
    output reg R,
    output reg [15:0]OUT
);
    // 64K of memory
    reg [15:0]mem[32767:0];
    wire [14:0]index;   // Index into memory

    initial begin
        OUT <= 0;
        R <= 0;

        // Zero memory
        $readmemh("zero.hex", mem, 0, 32767);
    end

    assign index = MAR >> 1;

    always @ (posedge clk) begin
        if (MEM_EN) begin
            if (WE0) begin
                mem[index][7:0] = MDR[7:0];
            end
            if (WE1) begin
                mem[index][15:8] = MDR[15:8];
            end

            OUT = mem[index];
            R <= 1; // Memory access is instantaneous
        end else begin
            R <= 0;
        end
    end
endmodule
