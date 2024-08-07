#!/bin/bash

# Check the current branch
current_branch=$(git branch --show-current)

# If on master branch, create main branch if it doesn't exist
if [ "$current_branch" == "master" ]; then
  git branch -M main
  git checkout main
fi

# Pull with --allow-unrelated-histories to merge unrelated histories
git pull origin main --allow-unrelated-histories

# Add all changes to staging
git add .

# Commit the changes with a message
git commit -m "created 2 masters and 3 worker nodes using terraform"

# Push changes to the 'main' branch and set upstream
git push --set-upstream origin main

# Additionally, push changes to the 'master' branch (if needed)
git push origin master --set-upstream origin master
