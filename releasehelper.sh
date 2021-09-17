#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <branch> [version]"
    exit 1
fi

BRANCH="$1"

case "$BRANCH" in
    "stable")
        ;;
    "beta")
        ;;
    "canary")
        BRANCH="beta"
        ;;
    *)
        echo "Invalid Branch!"
        exit 1
        ;;
esac

GITBRANCH="master"
[ "$BRANCH" = "beta" ] && GITBRANCH="ci-build"

git checkout origin/"$GITBRANCH" gradle.properties

VERSION="$2"
[ -z "$VERSION" ] && VERSION=$(git log -1 --pretty=%h origin/"$GITBRANCH")
VERSION_CODE=$(cat gradle.properties | grep 'magisk.versionCode')
STUB_VERSION_CODE=$(cat gradle.properties | grep 'magisk.stubVersion');

echo "{
  \"magisk\": {
    \"version\": \"${VERSION}\",
    \"versionCode\": \"${VERSION_CODE}\",
    \"link\": \"https://cdn.jsdelivr.net/gh/programminghoch10/Lygisk@deploy/${BRANCH}/app-release.apk\",
    \"note\": \"https://cdn.jsdelivr.net/gh/programminghoch10/Lygisk@deploy/${BRANCH}/note.md\"
  },
  \"stub\": {
    \"versionCode\": \"${STUB_VERSION_CODE}\",
    \"link\": \"https://cdn.jsdelivr.net/gh/programminghoch10/Lygisk@deploy/${BRANCH}/stub-release.apk\"
  }
}" > "$BRANCH".json

rm gradle.properties
