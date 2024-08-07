#!/bin/bash
# Script to create .gitignore file
echo ".DS_Store" > ../.gitignore
echo "*.tfstate" >> ../.gitignore
echo "*.tfstate.backup" >> ../.gitignore
echo "*.tfvars" >> ../.gitignore
echo ".terraform/" >> ../.gitignore
