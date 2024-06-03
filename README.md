# godocjson

Produces JSON-formatted Go documentation.

## Installation

```bash
curl -X GET https://raw.githubusercontent.com/cmalek/godocjson/master/install.sh | bash
```

This will download the installation script and install the appropriate go binary
for your OS and architecture into your local directory.   You may then move it to
the system folder of your choice.

## Usage

```godocjson [-e <pattern>] <directory>```

The **godocjson** scans `<directory>` for Go packages and outputs JSON-formatted
documentation to stdout

The options are as follows:

```
    -e   <pattern>   Exclude files that match specified pattern from processing.
                     Example usage:
                        godocjson -e _test.go ./go/sources/folder
```
