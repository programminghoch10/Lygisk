#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <branch>"
    exit 1
fi

BRANCH="$1"

case "$BRANCH" in
    "stable")
        ;;
    "beta")
        ;;
    "canary")
        ;;
    "madness")
        ;;
    *)
        echo "Invalid Branch!"
        exit 1
        ;;
esac

GITBRANCH="ci-build-$BRANCH"

git checkout origin/"$GITBRANCH" gradle.properties

VERSION=$(git log -1 --pretty=%h origin/"$GITBRANCH")
VERSION_CODE=$(cat gradle.properties | grep 'magisk.versionCode' | cut -f2 -d '=')
STUB_VERSION_CODE=$(cat gradle.properties | grep 'magisk.stubVersion' | cut -f2 -d '=')

case "$BRANCH" in
    "stable" | "beta")
        VERSION=v$(echo $VERSION_CODE | cut -c1-2).$(echo $VERSION_CODE | cut -c1-2 --complement)
        ;;
    *)
        ;;
esac

echo "{
  \"magisk\": {
    \"version\": \"${VERSION}\",
    \"versionCode\": \"${VERSION_CODE}\",
    \"link\": \"https://raw.githubusercontent.com/programminghoch10/Lygisk/deploy/${BRANCH}/app-release.apk\",
    \"note\": \"https://raw.githubusercontent.com/programminghoch10/Lygisk/deploy/${BRANCH}/note.md\"
  },
  \"stub\": {
    \"versionCode\": \"${STUB_VERSION_CODE}\",
    \"link\": \"https://raw.githubusercontent.com/programminghoch10/Lygisk/deploy/${BRANCH}/stub-release.apk\"
  }
}" > "$BRANCH".json

rm gradle.properties
