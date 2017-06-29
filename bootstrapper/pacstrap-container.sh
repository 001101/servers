#!/bin/bash
if [ -z "$1" ]; then
    echo "directory required"
    exit 1
fi
if [[ "$PWD" != "/var/lib/machines" ]]; then
    echo "please execute from var lib"
    exit 1
fi
if [ ! -d "$1" ]; then
    echo "no directory found: $1"
    exit 1
fi
pacstrap -i -c -d $1 base vim bash-completion --ignore linux --ignore nano --ignore linuxfirmware ${@:2}
