#!/bin/bash

APP_NAME=${APP_NAME:-"godocjson"}
VERSION=${VERSION:-"v1.0.1"}
PLATFORMS=("linux/amd64" "linux/arm64" "darwin/amd64" "darwin/arm64")

if test $(git rev-parse --abbrev-ref HEAD) = "master"; then
    if test -z "$(git status --untracked-files=no --porcelain)"; then
        MSG="$(git log -1 --pretty=%B)"
        echo "$MSG" | grep "Bump version"
        if test $? -eq 0; then
            VERSION=$(echo "$MSG" | awk -F→ '{print $2}')
            echo "---------------------------------------------------"
            echo "Releasing version ${VERSION} ..."
            echo "---------------------------------------------------"
            echo
            echo
            git push --tags origin master
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
            cd build && \
                gh release create $VERSION \
                    "${APP_NAME}-${VERSION}-linux-amd64.tar.gz#Linux Intel 64-bit" \
                    "${APP_NAME}-${VERSION}-linux-arm64.tar.gz#Linux ARM 64-bit" \
                    "${APP_NAME}-${VERSION}-darwin-amd64.tar.gz#macOS Intel 64-bit" \
                    "${APP_NAME}-${VERSION}-darwin-arm64.tar.gz#macOS ARM 64-bit" \
                    --title "${APP_NAME} ${VERSION}" \
                    --notes "Official release of ${APP_NAME}-${VERSION}."
        else
            echo "Last commit was not a bumpversion; aborting."
            echo "Last commit message: ${MSG}"
        fi
    else
        git status
        echo
        echo
        echo "------------------------------------------------------"
        echo "You have uncommitted changes; aborting."
        echo "------------------------------------------------------"
    fi
else
    echo "You're not on master; aborting."
fi
