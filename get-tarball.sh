#!/usr/bin/env bash

IMAGE=slac-buildroot
for a in $@; do
	case $a in
	--remote|r)
		IMAGE=ghcr.io/jjl772/slac-buildroot
		;;
	*)
		;;
	esac
done

function get_tarball {
	docker run --rm -it -v "$PWD":"$PWD" -w "/sdf/sw/epics/package/linuxRT" $IMAGE:$1-$2 bash -c "tar -cf \"$PWD/slac-buildroot-$1-$2.tgz\" buildroot-$1"
}

get_tarball 2019.08 x86_64 
#get_tarball 2019.08 i686 
#get_tarball 2019.08 zynq

