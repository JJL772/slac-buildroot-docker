#!/usr/bin/env bash

function do_build {
    docker build . -f Dockerfile.buildroot -t "slac-buildroot:${1}-${2}" --build-arg="BUILDROOT_VERSION=${1}" --build-arg="BUILDROOT_ARCH=${2}" \
        --build-arg="USER=$(id -u)" --build-arg="GROUP=$(id -g)"
}

do_build "2019.08" x86_64
do_build "2019.08" i686
do_build "2019.08" arm
