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

pacstrap -i -c -d $1 base vim bash-completion --ignore linux --ignore nano --ignore linux-firmware ${@:2}
if [ $? -ne 0 ]; then
    echo "failed to pacstrap...see previous errors"
    exit 1
fi
name=$(echo $1 | sed "s#/##g")
mkdir -p /etc/systemd/nspawn
cat /usr/share/epiphyte-servers/bootstrap/nspawn.template > /etc/systemd/nspawn/$name.nspawn
