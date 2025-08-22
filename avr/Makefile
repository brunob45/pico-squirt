CC=avr-gcc
CFLAGS=-mmcu=avr16dd28 -B lib/gcc/dev -isystem lib/gcc/include -O2 -DF_CPU=24000000UL

SRCS=main.cpp
OBJS=$(subst .cpp,.o,$(SRCS))
OUTP=main.elf

all: $(OBJS)
	$(CC) $(CFLAGS) -o $(OUTP) $(OBJS)

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OUTP) $(OBJS)