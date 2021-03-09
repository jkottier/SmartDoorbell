#!/bin/sh
# JPEG address (only enter the digits after 0x)
ADDRESS=551634
# Get ppsapp PID
PPSID=$(ps | grep -v grep | grep ppsapp | awk '{print $1}')
/mnt/mmc01/bin/jpeg-arm /proc/$PPSID/mem $ADDRESS 90000 mjpeg 2> /dev/null
