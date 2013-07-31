// Implements PC mux and actual PC logic

module PC_MUX(
    input wire clk,
    input wire LD_PC,       // Load PC this cycle
    input wire [1:0]PC_SEL, // PC source
    input wire [15:0]bus,   // PC input from data bus
    input wire [15:0]adder, // PC input from address adder
    output reg [15:0]PC
);

    // PC sources
    parameter INC = 2'd0;   // PC = PC + 2
    parameter BUS = 2'd1;   // PC = bus
    parameter ADDER = 2'd2; // PC = adder

    initial begin
        PC <= 0;
    end

    always @ (posedge clk) begin
        if (LD_PC) begin
            case(PC_SEL)
                INC: PC <= PC + 2;
                BUS: PC <= bus;
                ADDER: PC <= adder;
                default: PC <= 16'hxxxx;    // Undefined
            endcase
        end
    end

endmodule
