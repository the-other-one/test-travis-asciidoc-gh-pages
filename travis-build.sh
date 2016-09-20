#!/bin/bash
set -ev
./gradlew --no-daemon build asciidoc

if [ "${TRAVIS_PULL_REQUEST}" == "false" -a "${TRAVIS_BRANCH}" == "master" ]; then
  echo "git ls-remote origin gh-pages = `git ls-remote origin gh-pages`"
  if [ "`git ls-remote origin gh-pages`" == "" ]; then
    echo '****************************************************'
    echo '***** Executing publishGhPages with PghPageType=init'
    echo '****************************************************'
    ./gradlew --no-daemon publishGhPages --rerun-tasks --info --stacktrace -PghPageType=init
  fi
  echo '******************************************************'
  echo '***** Executing publishGhPages with PghPageType=latest'
  echo '******************************************************'
  ./gradlew --no-daemon publishGhPages --rerun-tasks --info --stacktrace -PghPageType=latest

  echo '*******************************************************'
  echo '***** Executing publishGhPages with PghPageType=version'
  echo '*******************************************************'
  ./gradlew --no-daemon publishGhPages --rerun-tasks --info --stacktrace -PghPageType=version
fi
