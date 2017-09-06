#!/bin/bash
SYSPACK="/etc/epiphyte.d/syspack.conf"
PACKCON="/tmp/packcon.working"
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

ssh_target="$SUDO_SSH_USER@$HOST:$LOCATION/"
scp -r $ssh_target $DEPLOY_TO
if [ $? -ne 0 ]; then
    echo "unable to update syspack definitions."
    exit 1
fi

_apply() {
    echo
    echo "==========="
    echo "applying $1"
    local _path=$_use/$1/
    mkdir -p $_path
    for f in $(find $_path -type f); do
        local _adjust=$(echo $f | sed "s#$_path#/etc/#g")
        echo "  -> $_adjust"
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

echo $(date +%Y-%m-%dT%H:%M:%S) > $PACKCON
pacman -Sl epiphyte | grep installed | cut -d " " -f 2-100 >> $PACKCON
scp $PACKCON ${ssh_target}"../../packcon/$HOSTNAME.packcon"
exit 0
