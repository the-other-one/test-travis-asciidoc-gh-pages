#!/bin/bash
set -ev
./gradlew build asciidoc
if [ "${TRAVIS_PULL_REQUEST}" = "false" -a "${TRAVIS_BRANCH}" = "master" ]; then
  git show-ref --verify --quiet refs/heads/gh-pages
  if [ $? -ne 0 ]
  then
    ./gradlew --info --stacktrace publishGhPages --rerun-tasks -PghPageType=init
  fi
  ./gradlew --info --stacktrace publishGhPages --rerun-tasks -PghPageType=latest
  ./gradlew --info --stacktrace publishGhPages --rerun-tasks -PghPageType=version
fi
