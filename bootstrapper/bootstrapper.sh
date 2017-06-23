#!/bin/bash
read -p "bootstrap server (y/n)? " yn
if [[ "$yn" != "y" ]]; then
    exit 0
fi
echo "bootstrapper..."
BOOTSTRAP="/opt/epiphyte/servers/bootstrap/"
read -p "ssh port? " sshport
if [ -z "$sshport" ]; then
    sshport="22"
fi
if [ "$sshport" -ge 0 -a "$sshport" -le 65535 ]; then 
    echo "using $sshport"
else
    echo "invalid ssh port...$sshport"
    exit 1
fi
SSH_IND="#SSH_PORT#"
cat $BOOTSTRAP/sshd_config.template | sed "s/$SSH_IND/$sshport/g" > /etc/ssh/sshd_config
cat $BOOTSTRAP/iptables.template | sed "s/$SSH_IND/$sshport/g" > /etc/iptables/iptables.rules
cat $BOOTSTRAP/resolv.template > /etc/resolv.conf
cat $BOOTSTRAP/vimrc.template > /etc/vimrc
