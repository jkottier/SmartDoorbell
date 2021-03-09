#!/bin/sh
/mnt/mmc01/bin/mosquitto_pub -h 192.168.123.456 \
-m "{\"diskspace\":{"$(df /mnt/mmc01/ -m | awk 'NR==2 { print("\"total_diskspace\":"$2",\"used_diskspace\":"$3",\"available_diskspace\":"$4",\"used_percentage\":"$5"}") }' \
| sed 's/%//')"}" -t home/doorbell/diskspace -u username -P password

