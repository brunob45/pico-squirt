CC=gcc/bin/avr-gcc
CFLAGS=-mmcu=avr16dd28 -B lib/gcc/dev -isystem lib/gcc/include -O2 -DF_CPU=24000000UL

SRCS=main.cpp twi.cpp spi.cpp
OBJS=$(subst .cpp,.o,$(SRCS))
NAME=main

all: $(OBJS)
	$(CC) $(CFLAGS) -o $(NAME).elf $(OBJS)

target: $(NAME).elf
	gcc/bin/avr-objcopy -O ihex $(NAME).elf $(NAME).hex

install: $(NAME).hex
	pymcuprog write -t uart -u COM4 -d avr16dd28 -m flash -f main.hex

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OBJS)

cleanall: clean
	rm -f $(OUTP)
