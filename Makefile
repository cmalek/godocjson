
.PHONY: build build-alpine clean test help default version image_name release



APP_NAME=godocjson

VERSION := "v1.0.2"
PACKAGE := "godocjson"

default: build

help:
	@echo 'Management commands for godocjson:'
	@echo
	@echo 'Usage:'
	@echo '    make build           Compile the project.'
	@echo '    make upload          Upload to github releases.'
	@echo '    make release         Push code to gihub, and do build and upload.'
	@echo '    make get-deps        runs go get, mostly used for ci.'
	@echo '    make clean           Clean the directory tree.'
	@echo

release:
	@echo "GOPATH=${GOPATH}"
	APP_NAME=$(APP_NAME) VERSION=$(VERSION) bin/release.sh

get-deps:
	go mod tidy
	go get

build:
	APP_NAME=$(APP_NAME) VERSION=$(VERSION) bin/build.sh

upload:
	APP_NAME=$(APP_NAME) VERSION=$(VERSION) bin/upload.sh

clean:
	@test ! -e build || rm -rf build