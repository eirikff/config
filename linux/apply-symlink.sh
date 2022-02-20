#! /usr/bin/env bash

echo "Home directory: $HOME"

echo "Making backups of dotfiles in already in home directory"
mv -i $HOME/.bashrc $HOME/.bashrc.bak
mv -i $HOME/.bash_aliases $HOME/.bash_aliases.bak
mv -i $HOME/.vimrc $HOME/.vimrc.bak
mv -i $HOME/.tmux.conf $HOME/.tmux.conf.bak

echo "Making symlinks to dotfiles"
ln -s $PWD/.bashrc $HOME/.bashrc
ln -s $PWD/.bash_aliases $HOME/.bash_aliases
ln -s $PWD/.vimrc $HOME/.vimrc
ln -s $PWD/.tmux.conf $HOME/.tmux.conf

echo "Making symlinks to subdirectories in .config"
ln -s $PWD/.config/terminator $HOME/.config/terminator

