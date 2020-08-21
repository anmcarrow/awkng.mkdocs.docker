#!/bin/bash -x

BASEDIR="/mkdocs"
GIT_URI="https://github.com/anmcarrow/awkng.articles.git"
GIT_BRANCH="master"

if [[ ! -f "${BASEDIR}/docs/index.md" ]]
   then
       echo "There are no document base, going to get it."
       git clone "${GIT_URI}" "${BASEDIR}/docs/"
   else
       echo "There are document base already. Trying to update it."
       cd "${BASEDIR}/docs/"
       git pull origin "${GIT_BRANCH}"
       cd "${BASEDIR}"
fi

mkdocs serve

