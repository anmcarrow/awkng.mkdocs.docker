#!/bin/bash

BASEDIR="/mkdocs/docs"
GITURI="https://github.com/anmcarrow/awkng.articles.git"

if [[ ! -f "${BASEDIR}/index.md" ]]
   then
       echo "There are document base, going to get it."
       git clone "${GITURI}" "${BASEDIR}"
   else
       echo "There are document base already. Nothing to do."
fi

mkdocs serve

