#!/bin/bash
set -ev
./gradlew build asciidoc
if [ ("${TRAVIS_PULL_REQUEST}" = "false") -a ("${TRAVIS_BRANCH}" = "master") ]; then
  ./gradlew publishGhPages
  ./gradlew publishGhPages -PversionedGhPage=true
fi
