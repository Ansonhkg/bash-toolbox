#!/bin/bash
#
# NOTE:
# remember to chmod +x ./build.sh to make this script excutable
# to run: ./build.sh -n {project_name}

# 
# Build and deploy project
# $1: { String } PROJECT_NAME
#
function buildandDeploy(){

    # Replace commit version in index.html
    source ./commit.sh

    rm -rf ./build/$1  && 
    flutter build web --release --web-renderer canvaskit && 
    mv ./build/web ./build/$1 && 
    vercel ./build/$1 --prod --confirm && 
    vercel list $1 &&
    rm -rf ./build
}

#
# Get arguments
# -n = project name
#
while getopts "n:" arg; do
  case $arg in
    n) PROJECT_NAME=$OPTARG;;
  esac
done

# 
# Final Prompt to run build & deploy
# 
echo ""
echo "==========================="
echo "Project name: $PROJECT_NAME"
echo "==========================="
read -p "Are you sure? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    buildandDeploy $PROJECT_NAME
fi