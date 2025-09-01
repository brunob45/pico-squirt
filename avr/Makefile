CC=gcc/bin/avr-gcc
CFLAGS=-mmcu=avr16dd28 -B lib/gcc/dev -isystem lib/gcc/include -O2 -DF_CPU=24000000UL

SRCS=main.cpp spi.cpp adc.cpp #twi.cpp 
OBJS=$(subst .cpp,.o,$(SRCS))
NAME=main

.PHONY: all clean cleanall install

all: $(NAME).elf
target: $(NAME).hex

$(NAME).hex: $(NAME).elf
	gcc/bin/avr-objcopy -O ihex $(NAME).elf $(NAME).hex

$(NAME).elf: $(OBJS)
	$(CC) $(CFLAGS) -o $(NAME).elf $(OBJS)

%.o: %.cpp
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(OBJS)

cleanall: clean
	rm -f $(NAME).hex $(NAME).elf

install:
	pymcuprog write -t uart -u COM4 -d avr16dd28 -m flash -f main.hex
