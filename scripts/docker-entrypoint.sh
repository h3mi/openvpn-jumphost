#!/bin/sh

if [ "${DEBUG:-false}" = "true" ];
then
	set -x 
fi
set -e 
set -o pipefail

mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
    mknod /dev/net/tun c 10 200
fi


exec "$@"
