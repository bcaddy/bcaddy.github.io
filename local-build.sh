#!/usr/bin/env bash

# description
#   Runs or tests this jekyll website

#set -x #echo all commands

REPO_ROOT=$(git rev-parse --show-toplevel)

if [[ $1 == "run" ]]; then
    # Run the website with auto update on
    set -m
    bundle exec jekyll s -H 0.0.0.0 -l -open-url
    jekyll clean

elif [[ $1 == "test" ]]; then
    bundle exec jekyll b -d "_site$BASE_URL"
    ${REPO_ROOT}/tools/test.sh
    jekyll clean

else
    echo "Command not found. Please only use \"run\" or \"test\" "
fi