#!/bin/bash
HELP="--help"
SUB="-"
VALID=1
DO_VIM=$VALID
DO_RESOLV=$VALID
VIM_OPT="vim"
RESOLV_OPT="resolv"

_push_template() {
    echo "applying $2"
    if [ $1 -eq $VALID ]; then
        cat $BOOTSTRAP/$2.template > /etc/$3
    fi
}

for item in $*; do
	case "$item" in
        $SUB$RESOLV_OPT)
            DO_RESOLV=0
            ;;
        $SUB$VIM_OPT)
            DO_VIM=0
            ;;
		$HELP)
            echo "epiphyte-bootstrap-server [-<option> to disable an option]"
            echo "   available options: $RESOLV_OPT, $VIM_OPT"
            exit 1
			;;
	esac
done

read -p "bootstrap server (y/n)? " yn
if [[ "$yn" != "y" ]]; then
    exit 0
fi
echo "processing..."

BOOTSTRAP="/opt/epiphyte/servers/bootstrap/"
_push_template $DO_VIM vimrc "vimrc"
_push_template $DO_RESOLV resolv "resolv.conf"
