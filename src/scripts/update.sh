#!/bin/bash

BASEDIR="/mkdocs"
GIT_BRANCH="master"

cd "${BASEDIR}/docs/"

git config --global user.email "john@doe.com" > /dev/null
git config --global user.name "John Doe" > /dev/null

git pull origin "${GIT_BRANCH}"

