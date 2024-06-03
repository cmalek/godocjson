#!/bin/bash

APP_NAME="godocjson"
VERSION=$(cat version.txt)
if [ ! -e build ]; then
    echo "Build directory does not exist. Run build.sh first."
    exit 1
fi
cd build && \
  # Install GitHub CLI if not already installed
  gh release create $VERSION \
      "${APP_NAME}-${VERSION}-linux-amd64.tar.gz#Linux 64-bit" \
      "${APP_NAME}-${VERSION}-darwin-amd64.tar.gz#macOS 64-bit" \
      "${APP_NAME}-${VERSION}-windows-amd64.zip#Windows 64-bit" \
      --title "${APP_NAME} ${VERSION}" \
      --notes "Official release of ${APP_NAME}-${VERSION}."