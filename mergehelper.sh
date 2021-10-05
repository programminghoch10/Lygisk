#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <branch>"
    exit 1
fi

# in this context:
#  origin - original magisk repo
#  other - lygisk repo

MAGISK_CANARY_URL="https://raw.githubusercontent.com/topjohnwu/magisk-files/master/canary.json"
CI_EXTRA_COMMITS=1

BRANCH="$1"

case "$BRANCH" in
    "stable")
        # stable builds from lygisk master directly
        git checkout other/master
        #exit 0
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

MAGISK_CHANGES_COUNT=$(git log other/ci-build-$BRANCH..HEAD --pretty=%H | wc -l)
LYGISK_CI_LATEST_COMMIT=$(git log -1 other/ci-build-$BRANCH~$CI_EXTRA_COMMITS --pretty=format:"%an %ae %ad %s")
LYGISK_MASTER_LATEST_COMMIT=$(git log -1 other/master --pretty=format:"%an %ae %ad %s")
echo "MAGISK_CHANGES_COUNT=$MAGISK_CHANGES_COUNT"
echo "LYGISK_CI_LATEST_COMMIT=$LYGISK_CI_LATEST_COMMIT"
echo "LYGISK_MASTER_LATEST_COMMIT=$LYGISK_MASTER_LATEST_COMMIT"
if [ $MAGISK_CHANGES_COUNT -eq 0 ] && [ "$LYGISK_CI_LATEST_COMMIT" = "$LYGISK_MASTER_LATEST_COMMIT" ] ; then
    echo "CHANGED=false" >> $GITHUB_ENV
    echo "No changes detected!"
    exit 0
fi

echo "CHANGED=true" >> $GITHUB_ENV

if [ $BRANCH = "stable" ] ; then
    # no need to pick changes on stable
    exit 0
fi

echo "Merging recursively"
#git rebase -s recursive -X theirs origin/master other/master
for i in $(git log origin/master..other/master --reverse --pretty=%H); do
    git cherry-pick --strategy recursive -X theirs $i
done
