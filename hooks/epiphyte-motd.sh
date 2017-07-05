#!/bin/bash
MOTD=/etc/motd
echo > $MOTD
echo "===" >> $MOTD
cat /var/log/pacman.log | grep "starting full system upgrade" >> $MOTD
echo "===" >> $MOTD
echo >> $MOTD
