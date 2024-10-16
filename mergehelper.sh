#!/bin/bash

set -e
set -x

if [ -z "$1" ]; then
    echo "Usage: $0 <branch>" >&2
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
        echo "Invalid Branch!" >&2
        exit 1
        ;;
esac

git reset --hard

MAGISK_CHANGES_COUNT=$(git log other/ci-build-$BRANCH..HEAD --pretty=%H | wc -l)
LYGISK_CURRENT_MASTER_COMMIT=$(git log -1 other/master --pretty=%H)
git restore --source other/ci-build-$BRANCH -- ci-master-sha.txt
LYGISK_CI_MASTER_BASE_COMMIT=$(cat ci-master-sha.txt)
rm ci-master-sha.txt
echo "MAGISK_CHANGES_COUNT=$MAGISK_CHANGES_COUNT" >&2
echo "LYGISK_CURRENT_MASTER_COMMIT=$LYGISK_CURRENT_MASTER_COMMIT" >&2
echo "LYGISK_CI_MASTER_BASE_COMMIT=$LYGISK_CI_MASTER_BASE_COMMIT" >&2
if [ $MAGISK_CHANGES_COUNT -eq 0 ] && [ "$LYGISK_CURRENT_MASTER_COMMIT" = "$LYGISK_CI_MASTER_BASE_COMMIT" ] ; then
    echo "changed=false" >> "$GITHUB_OUTPUT"
    echo "No changes detected!" >&2
    exit 0
fi

echo "changed=true" >> "$GITHUB_OUTPUT"

# save the current master commit hash into a file for checking for changes next run
echo "$LYGISK_CURRENT_MASTER_COMMIT" > ci-master-sha.txt
git add ci-master-sha.txt
git commit -m "save master base commit sha"

if [ $BRANCH = "stable" ] ; then
    # no need to pick changes on stable
    exit 0
fi

echo "Merging recursively"
#git rebase -s recursive -X theirs origin/master other/master
for i in $(git log origin/master..other/master --reverse --pretty=%H); do
    git cherry-pick --strategy recursive -X theirs $i
done
