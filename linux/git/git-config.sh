# set vim as preferred editor for git
git config --global core.editor 'vim'

# set neat aliases for common commands
git config --global alias.st 'status'
git config --global alias.ci 'commit'
git config --global alias.co 'checkout'
git config --global alias.br 'branch'
git config --global alias.wtf 'log -p'

# define alias 'lg' for a better log
git config --global alias.lg 'log --all --graph --pretty="%C(#cccc00)%h%Creset %C(#888888)(%C(#00aa00)%cr%C(#888888))%Creset%C(auto)%d%Creset %s"'

