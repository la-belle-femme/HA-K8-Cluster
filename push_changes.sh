#!/bin/bash
git init
git remote add origin https://github.com/la-belle-femme/HA-K8-Cluster.git
git status
git add .
git commit -m "created 2 masters and 3 worker nodes using terraform "
git push --set-upstream origin main


# git pull origin main
# git add .
# git commit -m "$1"
# git push origin main