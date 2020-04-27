# Copy vimrc
if [[ -f "$HOME/.vimrc" ]]; then
    read -p ".vimrc exists. Do you want to [a]ppend, over[w]rite, or [c]ancel? " vimrc_prompt
    if [[ "$vimrc_prompt" == "a" ]]; then
        echo "Appending to .vimrc"
        cat vimrc >> $HOME/.vimrc 
    elif [[ "$vimrc_prompt" == "w" ]]; then
        echo "Overwriting .vimrc"
        cp -f vimrc $HOME/.vimrc
    fi
else
    echo "Copying .vimrc"
    cp vimrc $HOME/.vimrc
fi

# Copy bashrc
if [[ -f "$HOME/.bashrc" ]]; then
    read -p ".bashrc exists. Do you want to [a]ppend, over[w]rite, or [c]ancel? " bashrc_prompt
    if [[ "$bashrc_prompt" == "a" ]]; then
        echo "Appending to .bashrc"
        cat bashrc >> $HOME/.bashrc 
    elif [[ "$bashrc_prompt" == "w" ]]; then
        echo "Overwriting .bashrc"
        cp -f bashrc $HOME/.bashrc
    fi
else
    echo "Copying .bashrc"
    cp bashrc $HOME/.bashrc
fi

# Create config path
CONFIG_PATH="$HOME/.config"
echo "Creating $CONFIG_PATH"
mkdir -p "$CONFIG_PATH"

# Copy ps1
PS1_PATH="$CONFIG_PATH/ps1s"
mkdir -p "$PS1_PATH"
cp ps1s/* $PS1_PATH/
echo "Which PS1 to use? (enter blank for default)"
#\n* default\n* short\n* ip\n* root\n> "
for f in $(/usr/bin/env ls -1 ./ps1s/ps1-*); do
    echo -n "* "
    echo $f | sed -e 's/^.*ps1\-//'
done
read -p "> " ps1_choice
case "$ps1_choice" in
    "short")
        ps1_choice=ps1-short
        ;;
    "ip")
        ps1_choice=ps1-ip
        ;;
    "root")
        ps1_choice=ps1-root
        ;;
    *)
        ps1_choice=ps1-default
        ;;
esac
echo "Creating PS1 symlink"
ln -sf "$PS1_PATH/$ps1_choice" "$CONFIG_PATH/ps1"
grep -q -E 'source .+/ps1' $HOME/.bashrc
if [[ $? -ne 0 ]]; then
    echo "Adding ps1 line to bashrc"
    echo "source $CONFIG_PATH/ps1" >> $HOME/.bashrc
fi

# Create necessary paths for custom programs
LOCAL_SRC_PATH="$HOME/.local/src"
LOCAL_BIN_PATH="$HOME/.local/bin"

echo "Creating $LOCAL_SRC_PATH"
mkdir -p "$LOCAL_SRC_PATH"

echo "Creating $LOCAL_BIN_PATH"
mkdir -p "$LOCAL_BIN_PATH"

cp -r ./local/* $HOME/.local

# Apply git aliases
chmod +x git-aliases
./git-aliases

