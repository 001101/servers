#!/bin/bash
MOTD=/etc/motd
echo > $MOTD
echo "system status" >> $MOTD
echo "===" >> $MOTD
cat /var/log/pacman.log | grep "starting full system upgrade" | tail -n 1 | cut -d " " -f 1 | sed "s/\[//g;s/$/ -> full system upgrade/g" >> $MOTD
echo >> $MOTD
echo "epiphyte:" >> $MOTD
pacman -Sl epiphyte | grep installed | sed "s/^epiphyte //g;s/^/  version -> /g" >> $MOTD
echo "===" >> $MOTD
echo >> $MOTD
