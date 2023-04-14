#! /usr/bin/env bash

echo "Home directory: $HOME"

dotfiles=(".bashrc" ".bash_aliases" ".profile" ".vimrc")

echo "Making backups of dotfiles in already in home directory"
for filename in ${dotfiles[@]}; do
    mv -i $HOME/$filename $HOME/"$filename".bak.$(date -uI)
done

echo "Copying dotfiles from repo to home directory"
for filename in ${dotfiles[@]}; do
    cp ./$filename $HOME/$filename
done

echo "Copying .config folder"
cp -ir ./.config $HOME

