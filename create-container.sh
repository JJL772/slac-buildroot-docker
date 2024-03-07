#!/usr/bin/env bash

docker build . -f Dockerfile.buildroot -t rocky9-buildroot-2019.08-x86_64 --build-arg="BUILDROOT_VERSION=2019.08" --build-arg="BUILDROOT_ARCH=x86_64"
