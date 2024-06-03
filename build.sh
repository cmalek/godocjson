#!/bin/bash

APP_NAME="godocjson"
VERSION=$(cat version.txt)
PLATFORMS=("linux/amd64" "darwin/amd64" "windows/amd64")

if [ ! -e "build" ]; then
    mkdir build
fi

for PLATFORM in "${PLATFORMS[@]}"
do
    OS=$(echo $PLATFORM | cut -d'/' -f1)
    ARCH=$(echo $PLATFORM | cut -d'/' -f2)
    OUTPUT_NAME="build/${APP_NAME}-${VERSION}-${OS}-${ARCH}"
    if [ $OS = "windows" ]; then
        OUTPUT_NAME+=".exe"
    fi

    env GOOS=$OS GOARCH=$ARCH go build -o $OUTPUT_NAME
    if [ $? -ne 0 ]; then
        echo "An error has occurred! Aborting the script execution..."
        exit 1
    fi

    if [ $OS = "windows" ]; then
        zip "${OUTPUT_NAME}.zip" "$OUTPUT_NAME"
        rm "$OUTPUT_NAME"
    else
        tar -czvf "${OUTPUT_NAME}.tar.gz" "$OUTPUT_NAME"
        rm "$OUTPUT_NAME"
    fi
done