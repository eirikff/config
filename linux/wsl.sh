#!/usr/bin/env bash

# WSL specific
if [[ ! -z ${WSL_DISTRO_NAME} ]]; then
    # removes green box around some files in WSL
    LS_COLORS='ow=01;36;40'
    export LS_COLORS

    # enable gui in WSL2
    # source: https://medium.com/@japheth.yates/the-complete-wsl2-gui-setup-2582828f4577
    export DISPLAY="$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0"
    # don't use LIBGL_ALWAYS_INDIRECT because Rviz doesn't work well if we use it.
    #export LIBGL_ALWAYS_INDIRECT=1

    # enable splitting panes and being in the same directory
    # https://learn.microsoft.com/en-us/windows/terminal/tutorials/new-tab-same-directory#wsl
    PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'
fi

