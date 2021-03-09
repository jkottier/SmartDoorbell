#!/bin/sh
if [ ! -e /tmp/customrun ]; then
 echo custom > /tmp/customrun
 cp /mnt/mmc01/passwd /etc/passwd
 /mnt/mmc01/bin/busybox telnetd
 /mnt/mmc01/bin/busybox httpd -c /mnt/mmc01/wrk/httpd/httpd.conf -h /mnt/mmc01/www -p 8080
 /mnt/mmc01/bin/busybox tcpsvd -vE 0.0.0.0 21 /mnt/mmc01/bin/busybox ftpd -w &
 /mnt/mmc01/bin/busybox crond -L /mnt/mmc01/wrk/crond/crond.log -c /mnt/mmc01/wrk/crond/

 if [ -e /mnt/mmc01/bin/ppsapp ]; then
  PPSID=$(ps | grep -v grep | grep ppsapp | awk '{print $1}')
  kill $PPSID
  /mnt/mmc01/bin/ppsapp &
 fi
fi
