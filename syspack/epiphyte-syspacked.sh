#!/bin/bash
SYSPACK="/etc/epiphyte.d/syspack.conf"
DEPLOY_TO="/opt/epiphyte"
if [ ! -e $SYSPACK ]; then
    echo "no $SYSPACK file defined, please declare a syspack
=======

vim
---
$SYSPACK
---
HOST='host.fqdn.domain.name'
CATEGORY='<category>'
LOCATION='{$DEPLOY_TO}/source/syspack/'
"
    exit 1
fi

if [ -z "$SUDO_SSH_USER" ]; then
    echo "no ssh agent found"
    exit 1
fi

source $SYSPACK
_use="$DEPLOY_TO/syspack"
if [ -d "$_use" ]; then
    rm -rf "$_use"
fi

scp -r $SUDO_SSH_USER@$HOST:$LOCATION/ $DEPLOY_TO
if [ $? -ne 0 ]; then
    echo "unable to update syspack definitions."
    exit 1
fi

_apply() {
    echo
    echo "==========="
    echo "applying $1"
    local _path=$_use$1/
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


echo
echo "..."
echo "checking etcgit"
echo
cd /etc && git status
cd /etc && git diff-index --name-only HEAD --
cd /etc && git status -sb | grep 'ahead'
exit 0
