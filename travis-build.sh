#!/bin/bash
set -ev
echo asciidoc started
./gradlew build asciidoc
echo asciidoc finished

if [ "${TRAVIS_PULL_REQUEST}" == "false" -a "${TRAVIS_BRANCH}" == "master" ]; then
  echo git show-ref started
  set exists = `git show-ref refs/heads/gh-pages`
  echo exists: $exists
  if [ -n "$exists" ]; then
    echo gh-pages branch does not exist
    ./gradlew publishGhPages --rerun-tasks -PghPageType=init
    echo publishGhPages init finished
  fi
  echo publishGhPages latest started
  ./gradlew publishGhPages --rerun-tasks -PghPageType=latest
  echo publishGhPages latest finished
  echo publishGhPages version started
  ./gradlew publishGhPages --rerun-tasks -PghPageType=version
  echo publishGhPages version finished
fi
