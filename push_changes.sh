#!/bin/bash

# Initialize the git repository
git init

# Add the remote repository
git remote add origin https://github.com/la-belle-femme/HA-K8-Cluster.git

# Check the status of the working directory
git status

# Add all changes to staging
git add .

# Commit the changes with a message
git commit -m "created 2 masters and 3 worker nodes using terraform"

# Push changes to the 'main' branch and set upstream
git push --set-upstream origin main

# Pull the latest changes from 'main'
git pull origin main

# Add all changes to staging
git add .

# Commit with the message passed as a parameter
git commit -m "$1"

# Push changes to the 'main' branch
git push origin main

# Additionally, push changes to the 'master' branch
git push origin master

# Set upstream for 'master' branch and push changes
git push --set-upstream origin master
