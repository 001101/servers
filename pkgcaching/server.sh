#!/bin/bash
for f in $(find /var/cache/pacman/pkg -maxdepth 1 -type f -mtime +45 | sort); do
    echo "dropping: $f"
    rm -f $f
done
