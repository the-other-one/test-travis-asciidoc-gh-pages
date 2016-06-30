#!/bin/bash
set -ev
./gradlew build asciidoc
if [ "${TRAVIS_PULL_REQUEST}" = "false" -a "${TRAVIS_BRANCH}" = "master" ]; then
  git show-ref --verify --quiet refs/heads/gh-pages
  if [ $? -ne 0 ]
  then
    echo publishGhPages init started
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
