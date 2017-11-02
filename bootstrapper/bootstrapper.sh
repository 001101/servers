#!/bin/bash
HELP="--help"
SUB="-"
VALID=1
DO_SSH=$VALID
DO_IPTABLES=$VALID
DO_VIM=$VALID
DO_RESOLV=$VALID
IPTABLES_OPT="iptables"
SSHD_OPT="ssh"
VIM_OPT="vim"
RESOLV_OPT="resolv"


if [ -e "/etc/epiphyte.d/syspack.conf" ]; then
    echo "system is controlled via syspack, no-op"
    exit 0
fi

_push_template() {
    echo "applying $2"
    if [ $1 -eq $VALID ]; then
        cat $BOOTSTRAP/$2.template > /etc/$3
    fi
}

for item in $*; do
	case "$item" in
        $SUB$IPTABLES_OPT)
            DO_IPTABLES=0
            ;;
        $SUB$SSHD_OPT)
            DO_SSH=0
            ;;
        $SUB$RESOLV_OPT)
            DO_RESOLV=0
            ;;
        $SUB$VIM_OPT)
            DO_VIM=0
            ;;
		$HELP)
            echo "epiphyte-bootstrap-server [-<option> to disable an option]"
            echo "   available options: $IPTABLES_OPT, $SSHD_OPT, $RESOLV_OPT, $VIM_OPT"
            exit 1
			;;
	esac
done

read -p "bootstrap server (y/n)? " yn
if [[ "$yn" != "y" ]]; then
    exit 0
fi
echo "processing..."

BOOTSTRAP="/usr/share/epiphyte-servers/bootstrap/"
if [ $DO_SSH -eq $VALID ] || [ $DO_IPTABLES -eq $VALID ]; then
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
    if [ $DO_SSH -eq $VALID ]; then
        _push_template $DO_SSH "sshd_config" "ssh/sshd_config"
        sed -i "s/$SSH_IND/$sshport/g" /etc/ssh/sshd_config
    fi
    if [ $DO_IPTABLES -eq $VALID ]; then
        _push_template $DO_IPTABLES "iptables" iptables/iptables.rules
        sed -i "s/$SSH_IND/$sshport/g" /etc/iptables/iptables.rules
    fi
fi
_push_template $DO_VIM vimrc "vimrc"
_push_template $DO_RESOLV resolv "resolv.conf"
