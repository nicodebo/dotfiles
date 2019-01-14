#!/bin/bash

# https://stackoverflow.com/questions/3462955/putting-git-hooks-into-repository?noredirect=1&lq=1
HOOK_NAMES="post-checkout post-commit"
HOOK_DIR=$(git rev-parse --show-toplevel)/.git/hooks

for hook in $HOOK_NAMES; do
    ln -s -f ../../.bin/githooks/$hook $HOOK_DIR/$hook
done
