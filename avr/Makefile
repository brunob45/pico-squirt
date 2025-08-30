CC=gcc/bin/avr-gcc
CFLAGS=-mmcu=avr16dd28 -B lib/gcc/dev -isystem lib/gcc/include -O2 -DF_CPU=24000000UL

SRCS=main.cpp twi.cpp
OBJS=$(subst .cpp,.o,$(SRCS))
OUTP=main.elf

all: $(OBJS)
	$(CC) $(CFLAGS) -o $(OUTP) $(OBJS)

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OBJS)

cleanall: clean
	rm -f $(OUTP)