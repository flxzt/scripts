#!/usr/bin/env bash
# git_clean_commit_hist.sh

git checkout --orphan latest_branch # Checkout new branch
git add -A                          # Add all files and commit them
git commit -am "init"               # Commit with message
git branch -D main                  # Deletes the main branch
git branch -m main                  # Rename the current branch to main
git push -f origin main             # Force push main branch to github
git gc --aggressive --prune=all     # remove the old files
