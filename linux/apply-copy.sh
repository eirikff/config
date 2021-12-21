#! /usr/bin/env bash

echo "Home directory: $HOME"

echo "Making backups of dotfiles in already in home directory"
mv -i $HOME/.bashrc $HOME/.bashrc.bak
mv -i $HOME/.bash_aliases $HOME/.bash_aliases.bak
mv -i $HOME/.vimrc $HOME/.vimrc.bak
mv -i $HOME/.tmux.conf $HOME/.tmux.conf.bak

echo "Copying dotfiles from repo to home directory"
cp ./.bashrc $HOME/.bashrc
cp ./.bash_aliases $HOME/.bash_aliases
cp ./.vimrc $HOME/.vimrc
cp ./.tmux.conf $HOME/.tmux.conf

echo "Copying .config folder"
cp -ir ./.config $HOME/.config
cp -ir "./.local" "$HOME/.local"

