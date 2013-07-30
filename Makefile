BIN := ./lc3.o

SRCS += lc3.v
SRCS += alu.v
SRCS += test.v

VFLAGS += -g 2005

all: $(BIN)

$(BIN): $(SRCS)
	iverilog $(VFLAGS) -o $@ $(SRCS)

simulate: $(BIN)
	$(BIN)
