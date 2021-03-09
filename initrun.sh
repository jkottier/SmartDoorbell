#!/bin/sh

## WARNING MOST OF THE BELOW ARE REQUIRED FOR THE DEVICE TO BOOT
## ONLY MODIFY THIS FILE IF YOU KNOW WHAT YOU'RE DOING.

# Umount mmc from this location
umount /opt/pps

# Mount original app partition
MTDNUM=5
mount -t cramfs /dev/mtdblock$MTDNUM /opt/pps

# Mount mmc at correct location
mkdir -p /mnt/mmc01
mount -t vfat /dev/mmcblk0p1 /mnt/mmc01

# Anything you place at this location executes before ppsapp launches

# Gets a copy of your home directory (including ppsapp) saved to your SD card during boot (if not already done)
if [ ! -e /mnt/mmc01/backup ]; then mkdir /mnt/mmc01/backup; fi
if [ ! -e /mnt/mmc01/backup/home ]; then tar xzf /opt/pps/app.tar.gz -C /mnt/mmc01/backup/; fi

# Run original app partition code
[ -e /opt/pps/initrun.sh ] && cp /opt/pps/initrun.sh /tmp/PPStartOrig && chmod +x /tmp/PPStartOrig && /tmp/PPStartOrig &
# Now flag the hack is done
echo done > /tmp/hack

# Anything you place at this location executes while the device is booting

# These lines have the same effect as the flash changes I made directly
while true; do
 sleep 10
 if [ -e /mnt/mmc01/custom.sh ]; then
  cp /mnt/mmc01/custom.sh /tmp/custom.sh
  chmod +x /tmp/custom.sh
  /tmp/custom.sh
 fi
done
