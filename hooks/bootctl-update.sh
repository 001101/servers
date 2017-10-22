#!/bin/bash
version=$(bootctl status 2>/dev/null | grep "systemd\-boot "| sed -n -e 's/^.*systemd-boot//p' | sed 's/[^0-9]*//g' | uniq)
current=$(bootctl --version | head -n 1 | cut -d " " -f 2)
if [ ! -z "$version" ]; then
    if [ $version != $current ]; then
        echo "===NOTICE==="
        read -p "bootctl update ($version != $current) (y/n)? " yn
        if [[ $yn == "y" ]]; then
            bootctl update
        fi
        echo "===NOTICE==="
    fi
fi
