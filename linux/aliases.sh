#!/usr/bin/env bash

# ls
alias ls='ls -CF --color=auto'
alias ll='ls -alF'
alias la='ls -A'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# less interpret ANSI
alias less='less -R'

# open current folder in file explorer
if [[ ! -z ${WSL_DISTRO_NAME} ]]; then
    alias expl="explorer.exe ."
else
    alias expl="xdg-open ."
fi

# old vim can still be accessed through vi
if command -v nvim &>/dev/null; then
    alias vim="nvim"
fi

