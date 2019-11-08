parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
 }
export PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]\[\033[1;33m\]\t\[\033[0;37m\]/\[\033[1;36m\]\u\[\033[0;37m\]@\[\033[1;34m\]\h\[\033[0;37m\]:\[\033[1;33m\]\W\[\033[0;33m\]\$(parse_git_branch)\[\033[0;37m\]$\[\033[0m\]"
