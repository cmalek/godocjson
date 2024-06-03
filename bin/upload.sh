#!/bin/bash

APP_NAME=${APP_NAME:-"godocjson"}
VERSION=${VERSION:-"v1.0.3"}
if [ ! -e build ]; then
    echo "Build directory does not exist. Run build.sh first."
    exit 1
fi
cd build && \
  # Install GitHub CLI if not already installed
  gh release create $VERSION \
      "${APP_NAME}-${VERSION}-linux-amd64.tar.gz#Linux Intel 64-bit" \
      "${APP_NAME}-${VERSION}-linux-arm64.tar.gz#Linux ARM 64-bit" \
      "${APP_NAME}-${VERSION}-darwin-amd64.tar.gz#macOS Intel 64-bit" \
      "${APP_NAME}-${VERSION}-darwin-arm64.tar.gz#macOS ARM 64-bit" \
      --title "${APP_NAME} ${VERSION}" \
      --notes "Official release of ${APP_NAME}-${VERSION}."