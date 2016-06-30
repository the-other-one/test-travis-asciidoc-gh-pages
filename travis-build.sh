#!/bin/bash
set -ev
./gradlew build asciidoc

if [ "${TRAVIS_PULL_REQUEST}" == "false" -a "${TRAVIS_BRANCH}" == "master" ]; then
  git show-ref
  set exists = `git ls-remote origin gh-pages`
  echo exists: "$exists"
  if [ "$exists" == "" ]; then
    echo Branch gh-pages does not exists.
    ./gradlew publishGhPages --rerun-tasks -PghPageType=init
  fi
  ./gradlew publishGhPages --rerun-tasks -PghPageType=latest
  ./gradlew publishGhPages --rerun-tasks -PghPageType=version
fi
