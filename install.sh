#!/bin/bash

VERSION="v1.0.0"
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case $ARCH in
    x86_64) ARCH="amd64" ;;
    arm64) ARCH="arm64" ;;
    aarch64) ARCH="arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

FILE="godocjson-${VERSION}-${OS}-${ARCH}"
TARFILE="${FILE}.tar.gz"
URL="https://github.com/cmalek/godocjson/releases/download/${VERSION}/${TARFILE}"

curl -L $URL -o $TARFILE
tar -xzvf --strip-components=1 $TARFILE
if [ ! -e /usr/local/bin ]; then
    sudo mkdir -p /usr/local/bin
fi
sudo mv $FILE godocjson
rm -f $FILE $TARFILE