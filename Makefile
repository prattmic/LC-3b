NAME := lc3

BIN := ./$(NAME).o
BIN_TEST := ./$(NAME)_test.o

SRCS += lc3.v
SRCS += alu.v
SRCS += reg_file.v
SRCS += pc_mux.v
SRCS += cc.v
SRCS += mar_mux.v
SRCS += ir.v
SRCS += address_adder.v
SRCS += shifter.v
SRCS += mdr.v
SRCS += memory.v

TESTS += test.v
TESTS += alu_test.v
TESTS += reg_file_test.v
TESTS += pc_mux_test.v
TESTS += cc_test.v
TESTS += mar_mux_test.v
TESTS += address_adder_test.v
TESTS += shifter_test.v
TESTS += mdr_test.v
TESTS += memory_test.v

VFLAGS += -g 2005 -Wall

all: $(BIN)

$(BIN): $(SRCS)
	iverilog $(VFLAGS) -o $@ $^

$(BIN_TEST): $(SRCS) $(TESTS)
	iverilog $(VFLAGS) -o $@ $^

simulate: $(BIN)
	$(BIN)

test: $(BIN_TEST)
	$(BIN_TEST)

clean:
	-rm $(BIN) $(BIN_TEST)
