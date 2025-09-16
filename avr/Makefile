PREFIX= # gcc/bin/ # used in windows
CFLAGS=-mmcu=avr16dd28 -B lib/gcc/dev -isystem lib/gcc/include -O2 -DF_CPU=24000000UL

SRCS=main.cpp
OBJS=$(subst .cpp,.o,$(SRCS))
NAME=main

.PHONY: all clean cleanall install

all: $(NAME).elf
target: $(NAME).hex

$(NAME).hex: $(NAME).elf
	$(PREFIX)avr-objcopy -O ihex $(NAME).elf $(NAME).hex

$(NAME).elf: $(OBJS)
	$(PREFIX)avr-gcc $(CFLAGS) -o $(NAME).elf $(OBJS)
	$(PREFIX)avr-size $(NAME).elf

$(NAME).S: $(NAME).elf
	$(PREFIX)avr-objdump -S $(NAME).elf > $(NAME).S

%.o: %.cpp
	$(PREFIX)avr-gcc $(CFLAGS) -c $<

clean:
	rm -f $(OBJS)

cleanall: clean
	rm -f $(NAME).hex $(NAME).elf

install:
	pymcuprog write -t uart -u COM4 -d avr16dd28 -m flash -f main.hex
