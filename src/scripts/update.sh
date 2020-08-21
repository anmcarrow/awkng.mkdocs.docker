#!/bin/bash

BASEDIR="/mkdocs"
GIT_BRANCH="master"

cd "${BASEDIR}/docs/"
git pull origin "${GIT_BRANCH}"

