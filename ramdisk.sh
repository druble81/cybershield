#!/bin/bash
sudo mkdir /tmp/ramdisk
sudo mount -t tmpfs -o size=64m myramdisk /tmp/ramdisk
/home/pi/Desktop/adf43513 500 2500000 0
pkill -f adf4351
