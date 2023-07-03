#!/usr/bin/env bash

# description
#   Runs or tests this jekyll website

#set -x #echo all commands

if [[ $1 == "run" ]]; then
    # Run the website with auto update on
    set -m
    bundle exec jekyll s -H 0.0.0.0 -l -open-url
    jekyll clean

elif [[ $1 == "test" ]]; then
    bundle exec jekyll b -d "_site"
    bundle exec htmlproofer _site --disable-external --check-html --allow_hash_href
    jekyll clean

elif [[ $1 == "update" ]]; then
    echo "See this page for instructions on updating Chirpy:"
    echo "https://github.com/cotes2020/jekyll-theme-chirpy/wiki/Upgrade-Guide"
    echo ""
    echo "See this page for instructions on updating Ruby"
    echo "https://stackoverflow.com/questions/51126403/you-dont-have-write-permissions-for-the-library-ruby-gems-2-3-0-directory-ma"

else
    echo "Command not found. Please only use \"run\" or \"test\" "
fi