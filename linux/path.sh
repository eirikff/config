#!/usr/bin/env bash

function add_to_path() {
    if [ -d $1 ]; then
	export PATH="$1:$PATH"
	return 0
    fi
    return 1
}

add_to_path "$HOME/.local/bin"

