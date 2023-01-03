#!/usr/bin/env bash

# description
#   Runs or tests this jekyll website

#set -x #echo all commands

if [[ $1 == "run" ]]; then
    # Run the website with auto update on
    set -m
    bundle exec jekyll s -H 0.0.0.0 -l -open-url
    bundle exec jekyll clean

elif [[ $1 == "test" ]]; then
    bundle exec jekyll b -d "_site"
    bundle exec htmlproofer _site --disable-external --check-html --allow_hash_href
    bundle exec jekyll clean

else
    echo "Command not found. Please only use \"run\" or \"test\" "
fi