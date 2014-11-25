#!/bin/sh

rm -rf .git/hooks/pre-commit
rm -rf .git/hooks/commit-msg
ln -s -f ../../install/pre_commit .git/hooks/pre-commit
ln -s -f ../../install/commit_msg .git/hooks/commit-msg
