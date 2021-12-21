# ls
alias ls='ls -CF --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# open current folder in file explorer
if [[ ! -z ${WSL_DISTRO_NAME} ]]; then
    alias expl="explorer.exe ."
else
    alias expl="xdg-open ."
fi

