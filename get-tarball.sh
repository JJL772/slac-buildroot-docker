#!/usr/bin/env bash

IMAGE=slac-buildroot
for a in $@; do
	case $a in
	--remote|-r)
		IMAGE=ghcr.io/jjl772/slac-buildroot
		shift
		;;
	-v)
		VER="$2"
		shift 2
		;;
	-t)
		TAG="$2"
		shift 2
		;;
	*)
		;;
	esac
done

if [ -z "$TAG" ] || [ -z "$VER" ]; then
	echo "-t and -v are required"
	exit 1
fi

docker run --rm -v "$PWD":"$PWD" -w "/sdf/sw/epics/package/linuxRT" "$IMAGE:$TAG" bash -c "tar -cf \"$PWD/buildroot-$TAG.tgz\" buildroot-$VER"
