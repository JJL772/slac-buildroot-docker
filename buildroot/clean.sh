#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

rm -rf ./buildroot-*
rm -rf ./download
rm -rf ./host
