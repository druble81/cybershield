#!/bin/bash

cd /home/pi/Desktop

./update_gui

#bash loadrd.sh 35 110

sudo bash alloffrd.sh
sudo rm /tmp/ramdisk/*.txt
sudo rm /tmp/ramdisk/*.TXT
lxterminal -e "bash testscan.sh 25"
