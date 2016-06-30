#!/bin/bash
set -ev
./gradlew build asciidoc

if [ "${TRAVIS_PULL_REQUEST}" == "false" -a "${TRAVIS_BRANCH}" == "master" ]; then
  set exists = `git show-ref refs/heads/gh-pages`
  if [ -n $exists ]; then
    ./gradlew publishGhPages --rerun-tasks -PghPageType=init
  fi
  ./gradlew publishGhPages --rerun-tasks -PghPageType=latest
  ./gradlew publishGhPages --rerun-tasks -PghPageType=version
fi
