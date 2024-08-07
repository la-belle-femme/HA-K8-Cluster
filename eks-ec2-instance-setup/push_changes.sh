#!/bin/bash
# Script to push changes to Git repository
git add .
git commit -m "Auto-commit: $(date)"
git push origin main
