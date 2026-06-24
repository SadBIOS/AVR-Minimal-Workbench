MCU = atmega328p
FREQ = 16000000UL
FILE = main
APN = m328p

# Windows
avr-gcc_root_win32_64     = <TOOLCHAIN_DIR>/bin/avr-gcc.exe
avr-objcopy_root_win32_64 = <TOOLCHAIN_DIR>/bin/avr-objcopy.exe
avrdude_root_win32_64     = <AVRDUDE_DIR>/avrdude.exe

# Linux
avr-gcc_root_lin32_64     = <TOOLCHAIN_DIR>/bin/avr-gcc
avr-objcopy_root_lin32_64 = <TOOLCHAIN_DIR>/bin/avr-objcopy
avrdude_root_lin32_64     = <AVRDUDE_DIR>/bin/avrdude


ifeq ($(OS),Windows_NT)
    avr_gcc = $(avr-gcc_root_win32_64)
    avr_objcopy = $(avr-objcopy_root_win32_64)
    avrdude = $(avrdude_root_win32_64)
else
    avr_gcc = $(avr-gcc_root_lin32_64)
    avr_objcopy = $(avr-objcopy_root_lin32_64)
    avrdude = $(avrdude_root_lin32_64)
endif

default:	# default compile
	$(avr_gcc) -v -Wall -Os -DF_CPU=$(FREQ) -mmcu=$(MCU) -c -o obj.o $(FILE).c
	$(avr_gcc) -v -Wall -o $(FILE)_intermediate.bin obj.o
	$(avr_objcopy) -v -O ihex -R .eeprom $(FILE)_intermediate.bin $(FILE)_firmware.hex

flash:		# upload firmware
	$(avrdude) -F -V -c usbasp -p $(APN) -B 10 -P usb -U flash:w:$(FILE)_firmware.hex -vvv

read:		# reads firmware from chip and dumps firmware
	$(avrdude) -F -V -c usbasp -p $(APN) -P usb -U flash:r:$(FILE)_dump.bin:r -vvv
	$(avr_objcopy) -v -O ihex -R .eeprom $(FILE)_dump.bin $(FILE)_dump.hex
	
erase:		# wipes on-chip flash
	$(avrdude) -F -V -c usbasp -p $(APN) -B 10 -P usb -e -vvv