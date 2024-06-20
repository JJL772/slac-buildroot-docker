#!/usr/bin/env bash

set -e

TOP="$(dirname "${BASH_SOURCE[0]}")"
pushd "$TOP" > /dev/null

./start-dev-container.sh

popd > /dev/null

docker exec -w "$PWD" -e "COLORTERM=${COLORTERM}" -e "TERM=${TERM}" -e "PATH=/build/host/bin:/bin:/usr/bin:/usr/local/bin" --user "$(id -u):$(id -g)" slac-buildroot-dev-container $@

