#!/usr/bin/env bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

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
    --download-only)
        DOWNLOADONLY=1
        shift
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

if [ "$ARCH" != "zynq" ] && [ "$ARCH" != "i686" ] && [ "$ARCH" != "x86_64" ]; then
    echo "$ARCH is not a valid arch choice, valid options are i686, x86_64, zynq"
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

if [ "$DOWNLOADONLY" == "1" ]; then
    exit 0
fi

# Make required symlinks
if [ ! -f "$DIR/site" ]; then
    pushd "$DIR" > /dev/null
    ln -s ../site-top site
    popd > /dev/null
fi

export FORCE_UNSAFE_CONFIGURE=1

pushd "$DIR" > /dev/null

# HACK! first call to print-version fails, after which it generates the required files. Eat the error and continue
make print-version 2> /dev/null || true
make defconfig

./site/scripts/br-installconf.sh -a $ARCH -f

# Undo a hack we did earlier. Re-order such that make is out of path
export PATH="/usr/bin:/bin:/sbin:$PATH"

# Build the toolchain *only*. That's what we care about :)
make toolchain -j$(nproc)

popd > /dev/null
