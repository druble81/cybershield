#!/bin/bash
sudo mkdir /tmp/ramdisk
sudo mount -t tmpfs -o size=64m myramdisk /tmp/ramdisk
