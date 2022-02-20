#! /usr/bin/env bash

echo "Home directory: $HOME"

echo "Making backups of old vscode settings.json in already in .config directory"
mv -i $HOME/.config/Code/User/settings.json  $HOME/.config/Code/User/settings.json.bak

# Make directory incase it doesn't exist yet
mkdir -p $HOME/.config/Code/User

echo "Making symlinks to Code in .config"
ln -s $PWD/settings.json $HOME/.config/Code/User/settings.json

