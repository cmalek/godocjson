#!/bin/bash

APP_NAME=${APP_NAME:-"godocjson"}
VERSION=${VERSION:-"v1.0.1"}
PLATFORMS=("linux/amd64" "linux/arm64" "darwin/amd64" "darwin/arm64")

if [ ! -e "build" ]; then
    mkdir build
fi

for PLATFORM in "${PLATFORMS[@]}"
do
    OS=$(echo $PLATFORM | cut -d'/' -f1)
    ARCH=$(echo $PLATFORM | cut -d'/' -f2)
    OUTPUT_NAME="${APP_NAME}-${VERSION}-${OS}-${ARCH}"

    env GOOS=$OS GOARCH=$ARCH go build -o build/$OUTPUT_NAME
    if [ $? -ne 0 ]; then
        echo "An error has occurred! Aborting the script execution..."
        exit 1
    fi

    tar -czvf "${OUTPUT_NAME}.tar.gz" -C build "$OUTPUT_NAME"
    mv "${OUTPUT_NAME}.tar.gz" build/
done