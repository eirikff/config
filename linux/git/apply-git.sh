#! /usr/bin/env bash

echo "Apply all git configs? (y/N)"
read apply_all

if [[ $apply_all -eq "y" ]]; then
    ./git-aliases.sh
    ./git-editor.sh
    ./git-lg.sh
    #./github-anon-email.sh
fi

unset apply_all

