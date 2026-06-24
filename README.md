## Cross Platform AVR MCU Minimal Development Environment
#### Setup for Microsoft Windows<sup>®</sup>:
* [MinGW-w64](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/) (download the *x86_64-posix-seh.7z* archive, also this is required for the ***make.exe*** binary)
* [AVR 8-Bit Toolchain (Windows)](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers) (this is the exact file name)
* [avrdude-vX.Y-windows-x64.zip](https://github.com/avrdudes/avrdude/releases) (version might change, pick the latest build)

> [!NOTE]  
> * rename ```mingw64/bin/mingw32-make.exe``` to ***make.exe***
> * add ```mingw64/bin``` to the OS Environment Variable
> * Follow the Makefile comments
> * Additional USB drivers may be required. Use ***Zadig*** if needed.
---
#### Setup for GNU Linux:
*  Install the **build-essential** meta package.
```bash
sudo apt install build-essential
```
* [AVR 8-Bit Toolchain (Linux)](https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers) (this is the exact file name, same for Microsoft Windows<sup>®</sup>)
* [avrdude_vX.Y_Linux_64bit.tar.gz](https://github.com/avrdudes/avrdude/releases)

> [!NOTE]  
> * Create the following file (you can use micro, you don't need to prove anything by using vim)
> ```bash
> sudo micro /etc/udev/rules.d/99-usbasp.rules
>```
> * Add the following content into that file
>```ruby
> SUBSYSTEM=="usb", ATTR{idVendor}=="16c0", ATTR{idProduct}=="05dc", MODE="0666"
> ``` 
> > The product ID **(pid=05dc)** and vendor ID is **(vid=16c0)** according to the **[developer](https://www.fischl.de/usbasp/)**.
> * Reload **udev** and reconnect the device
> ```bash
> sudo udevadm control --reload-rules
>```
>```bash
> sudo udevadm trigger
>```
---
> [!IMPORTANT]  
> This project has been tested for kernel **6.12.94+deb13** (Debian 13.5 "*Trixie*")
