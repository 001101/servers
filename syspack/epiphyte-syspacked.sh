#!/bin/bash
SYSPACK="/etc/epiphyte.d/syspack.conf"
if [ ! -e $SYSPACK ]; then
    echo "no $SYSPACK file defined, please declare a syspack
=======

vim
---
$SYSPACK
---
HOST='host.fqdn.domain.name'
CATEGORY='<category>'
LOCATION='/opt/epiphyte/syspack/'
"
    exit 1
fi
source $SYSPACK
#scp $HOST:$LOCATION $LOCATION

mkdir -p $LOCATION
_apply() {
    echo
    echo "==========="
    echo "applying $1"
    local _path=${LOCATION}$1/
    mkdir -p $_path
    for f in $(find $_path -type f); do
        local _adjust=$(echo $f | sed "s#$_path#/etc/#g")
        echo -n "  -> $_adjust"
        install -Dm 644 $f $_adjust
    done
    echo
    echo "==========="
    echo
}

_apply "common"
_apply "$CATEGORY"
_apply "$HOSTNAME"
