#!/bin/bash

# Get the latest commit 
LAST_COMMIT_SHA=$(git rev-parse HEAD)
echo "$LAST_COMMIT_SHA" | tr -d '\n' | pbcopy
# echo "Copied ${LAST_COMMIT_SHA}."

# find the word COMMIT_VERSION: and replace whatever string after to commit hash
sed -i -e 's/^<!-- COMMIT_VERSION: .* -->$/<!-- COMMIT_VERSION: '"$LAST_COMMIT_SHA"' -->/' ./web/index.html