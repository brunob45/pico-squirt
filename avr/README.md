# AVR slave device

## Build
```bash
$ make
```

## Upload
[pymcuprog](https://pypi.org/project/pymcuprog/)
```bash
$ pymcuprog -t uart -u /dev/ttyACM0 -d avr16dd28 ping
```

## Requirements
```bash
$ apt install gcc-avr avr-libc
$ pip install pymcuprog
```
or
```bash
$ wget https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/avr8-gnu-toolchain-3.7.0.1796-linux.any.x86_64.tar.gz
$ tar -xvf avr8-gnu-toolchain-3.7.0.1796-linux.any.x86_64.tar.gz
```
