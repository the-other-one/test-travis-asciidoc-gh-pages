#!/bin/bash
set -ev
./gradlew build asciidoc
if [ "${TRAVIS_PULL_REQUEST}" = "false" -a "${TRAVIS_BRANCH}" = "master" ]; then
  ./gradlew publishGhPages --rerun-tasks
  ./gradlew publishGhPages --rerun-tasks -PversionedGhPage=true
fi
