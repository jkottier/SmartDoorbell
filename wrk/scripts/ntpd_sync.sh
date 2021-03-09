#!/bin/sh
echo Before: $(date)
/mnt/mmc01/bin/busybox ntpd -n -q -p nl.pool.ntp.org 2>&1
echo After $(date)
