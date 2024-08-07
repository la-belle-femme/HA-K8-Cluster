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

# Check if there are merge conflicts
if [ $? -ne 0 ]; then
  echo "Merge conflicts detected. Please resolve them before proceeding."
  exit 1
fi

# Add all changes to staging
git add .

# Add .gitignore file to staging
git add .gitignore

# Commit the changes with a message
git commit -m "Added .terraform and large files to .gitignore"

# Push changes to the 'main' branch and set upstream
git push origin main --force

# Commit the remaining changes
git commit -m "created 2 masters and 3 worker nodes using terraform"

# Push changes to the 'main' branch and set upstream
git push --set-upstream origin main

# Optionally, push changes to the 'master' branch if it exists
if git show-ref --quiet refs/heads/master; then
  git push origin master --set-upstream origin master
fi
