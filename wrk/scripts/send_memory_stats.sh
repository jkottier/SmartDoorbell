#!/bin/sh
/mnt/mmc01/bin/mosquitto_pub -h 192.168.123.456 \
-m "{\"memory\":{"$(/mnt/mmc01/bin/busybox free | awk 'NR==2 {print \
"\"total_memory\":"$2",\"used_memory\":"$3 \
",\"free_memory\":"$4",\"buff_cache\":"$6 \
",\"available_memory\":"$7",\"available_percentage\":"int($7/$2*100)"}}"}') \
-t home/doorbell/memory -u username -P password
