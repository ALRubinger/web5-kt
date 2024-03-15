#!/bin/bash

# define function with params LAST_TAG, VERSION_TYPE, EXPECTED_TAG
function semverCheck() {
    LAST_TAG=$1
    VERSION_TYPE=$2
    EXPECTED_TAG=$3

    [[ $LAST_TAG =~ ^([a-zA-Z]*)([0-9.]*)(-[a-zA-Z0-9]*)?$ ]]
    PREFIX=${BASH_REMATCH[1]}
    RAW_VERSION=${BASH_REMATCH[2]}
    SUFFIX=${BASH_REMATCH[3]}
    
    NEW_VERSION=$(semver -i $VERSION_TYPE $RAW_VERSION)
    NEW_TAG="$PREFIX$NEW_VERSION$SUFFIX"
    if [ "$NEW_TAG" != "$EXPECTED_TAG" ]; then
        echo "FAIL !!! Expected: $EXPECTED_TAG -- Got >>> $NEW_TAG" 
        echo "LAST_TAG: $LAST_TAG"
        echo "PREFIX: $PREFIX"
        echo "SUFFIX: $SUFFIX"
        echo "VERSION_TYPE: $VERSION_TYPE"
        echo "RAW_VERSION: $RAW_VERSION"
        echo "NEW_VERSION: $NEW_VERSION"
        exit 1
    else
        echo "PASS"
    fi
}

semverCheck "v0.11.3-beta" "patch" "v0.11.4-beta"
semverCheck "v0.11.3-beta" "minor" "v0.12.0-beta"
semverCheck "v0.11.3-beta" "major" "v1.0.0-beta"

semverCheck "0.11.3-beta" "patch" "0.11.4-beta"
semverCheck "0.11.3-beta" "minor" "0.12.0-beta"
semverCheck "0.11.3-beta" "major" "1.0.0-beta"

semverCheck "v0.11.3" "patch" "v0.11.4"
semverCheck "v0.11.3" "minor" "v0.12.0"
semverCheck "v0.11.3" "major" "v1.0.0"

semverCheck "0.11.3" "patch" "0.11.4"
semverCheck "0.11.3" "minor" "0.12.0"
semverCheck "0.11.3" "major" "1.0.0"

semverCheck "v1.0.0-beta" "patch" "v1.0.1-beta"
semverCheck "v1.0.0-beta" "minor" "v1.1.0-beta"
semverCheck "v1.0.0-beta" "major" "v2.0.0-beta"

semverCheck "1.11.3-beta" "patch" "1.11.4-beta"
semverCheck "1.11.3-beta" "minor" "1.12.0-beta"
semverCheck "1.11.3-beta" "major" "2.0.0-beta"

semverCheck "v1.11.3" "patch" "v1.11.4"
semverCheck "v1.11.3" "minor" "v1.12.0"
semverCheck "v1.11.3" "major" "v2.0.0"

semverCheck "1.11.3" "patch" "1.11.4"
semverCheck "1.11.3" "minor" "1.12.0"
semverCheck "1.11.3" "major" "2.0.0"