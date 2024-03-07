#!/usr/bin/env bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

VERSION=
ARCH=

while [ -n "$1" ]; do
    case "$1" in 
    -v)
        VERSION="$2"
        shift 2
        ;;
    -a)
        ARCH="$2"
        shift 2
        ;;
    *)
        echo "Invalid option $a"
        exit 1
        ;;
    esac
done

if [ -z $VERSION ]; then
    echo "USAGE: setup.sh 2019.08"
    exit 1
fi

if [ "$ARCH" != "arm_zynq" ] && [ "$ARCH" != "i686" ] && [ "$ARCH" != "x86_64" ]; then
    echo "$ARCH is not a valid arch choice, valid options are i686, x86_64, arm_zynq"
    exit 1
fi

case $VERSION in
    2019.08)
        FILE="buildroot-2019.08.1"
        ;;
    2016.11.1)
        FILE="buildroot-2016.11.1"
        ;;
    *)
        echo "Unsupported version $VERSION"
        exit 1
        ;;
esac
DIR="buildroot-$VERSION-$ARCH"

mkdir -p download
if [ ! -f download/$FILE.tar.bz2 ]; then
    wget -O "download/$FILE.tar.bz2" "https://buildroot.org/downloads/$FILE.tar.bz2"
fi

if [ ! -d "$DIR" ]; then
    tar -xf "download/$FILE.tar.bz2"
    mv "$FILE" "$DIR"
fi

# Make required symlinks
if [ ! -f "$DIR/site" ]; then
    pushd "$DIR" > /dev/null
    ln -s ../site-top site
    popd > /dev/null
fi

# Apply patches and build
pushd "$DIR" > /dev/null
make print-version
./site/br-installconf.sh -a $ARCH -f -p
make -j$(nproc)
popd > /dev/null