#!/bin/bash -e

# Via conduit patch a local repo with phabricator's diff
# Normally you will run this a pre built step in Jenkins
if [ ! -z "${DIFF_ID}" ]; then
    echo "## Getting base rev for diff"
    BASE_GIT_COMMIT=$(echo {\"diff_id\": ${DIFF_ID}} | arc call-conduit differential.getdiff | awk -v RS=',' -v FS=':'     '$1~/\"sourceControlBaseRevision\"/ {print $2}' | tr -d \")

    echo "## Reset to base commit"
    git reset --hard ${BASE_GIT_COMMIT}

    echo "## Cleaning out repo"
    git clean -fdx

    echo "## Apply diff ${DIFF_ID}"
    arc patch --nobranch --no-ansi --diff $DIFF_ID --nocommit
fi