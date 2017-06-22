#!/bin/bash
source /etc/epiphyte.d/pkgcache.conf
if [ -z "$PACKAGE_HOST" ]; then
    echo "PACKAGE_HOST is not set"
    exit 1
fi
CACHED="cache/"
HOST_CACHE=$PACKAGE_HOST/$CACHED
CACHE=/var/cache/pacman/pkg/

# get what we don't have
rsync -av rsync://${HOST_CACHE}* $CACHE

# send what we have
includes=""
for f in $(find $CACHE -maxdepth 1 -type f -mtime -30); do
	name=$(basename $f)
	includes="$includes --include=$name"
done

if [ -z "$includes" ]; then
	echo "nothing to send"
else
	rsync -av $includes --exclude="*" $CACHE rsync://${HOST_CACHE}
fi
