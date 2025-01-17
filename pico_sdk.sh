#! /usr/bin/bash

cd /opt/
sudo mkdir pico -p
sudo chown lukasz:lukasz pico -R
cd pico

git clone https://github.com/raspberrypi/pico-sdk.git --branch master
cd pico-sdk
git submodule update --init
export PICO_SDK_PATH=/opt/pico/pico-sdk
# echo "export PICO_SDK_PATH=/home/lukasz/pico/pico-sdk" >> /home/lukasz/.zshrc

sudo apt install cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential gdb-multiarch -y
ln -s /usr/bin/gdb-multiarch /usr/bin/arm-none-eabi-gdb
code --install-extension chris-hock.pioasm
code --install-extension marus25.cortex-debug

sudo apt install automake autoconf build-essential texinfo libtool libftdi-dev libusb-1.0-0-dev -y
sudo apt install openocd -y
cd /opt/pico
git clone https://github.com/raspberrypi/openocd.git --branch rp2040 --depth=1
cd openocd
./bootstrap
./configure
make -j 4
sudo make install

echo -e "export PICO_SDK_PATH=/opt/pico/pico-sdk" >> ~/.profile
echo -e "export FREERTOS_KERNEL_PATH=/opt/pico/FreeRTOS-Kernel" >> ~/.profile
