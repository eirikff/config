#!/usr/bin/env bash

export VISUAL=vim
export EDITOR=$VISUAL

# needed for gnu screen 
# see: https://superuser.com/questions/1195962/cannot-make-directory-var-run-screen-permission-denied
export SCREENDIR="$HOME/.screen"

