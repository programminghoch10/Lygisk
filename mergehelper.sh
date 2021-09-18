#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <branch>"
    exit 1
fi

# in this context:
#  origin - original magisk repo
#  other - lygisk repo

MAGISK_CANARY_URL="https://raw.githubusercontent.com/topjohnwu/magisk-files/master/canary.json"

BRANCH="$1"

case "$BRANCH" in
    "stable")
        # stable builds from lygisk master directly
        git checkout other/master
        exit 0
        ;;
    "beta")
        # beta builds from newest magisk tag
        git checkout tags/$(git describe --tags --abbrev=0)
        ;;
    "canary")
        # canary builds from newest magisk canary
        SHA=$(curl --silent $MAGISK_CANARY_URL | grep version | head -n 1 | cut -f4 -d '"')
        git checkout $SHA
        ;;
    "madness")
        # madness builds from magisk master
        git checkout origin/master
        ;;
    *)
        echo "Invalid Branch!"
        exit 1
        ;;
esac

git reset --hard

#git rebase -s recursive -X theirs origin/master other/master
for i in $(git log origin/master..other/master --reverse --pretty=%H); do
    git cherry-pick --strategy recursive -X theirs $i
done