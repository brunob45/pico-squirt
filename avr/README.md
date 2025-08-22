# AVR slave device

## Build
```bash
$ make
```

## Upload
```bash
$ pymcuprog -t uart -u /dev/ttyACM0 -d avr16dd28 ping
```

## Requirements
```bash
$ apt install gcc-avr avr-libc
$ pip install pymcuprog
```
