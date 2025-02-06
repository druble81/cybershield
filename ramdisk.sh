#!/bin/bash
[ -f /tmp/ramdisk.done ] || (sudo mkdir /tmp/ramdisk && touch /tmp/ramdisk.done)
[ -f /tmp/ramdiskmount.done ] || (sudo mount -t tmpfs -o size=64m myramdisk /tmp/ramdisk && touch /tmp/ramdiskmount.done)

