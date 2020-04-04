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
cp ps1 $CONFIG_PATH/ps1
cp ps1-ip $CONFIG_PATH/ps1-ip
read -p "Use [s]tandard ps1 or [ip] ps1? " ps1_choice
if [[ "$ps1_choice" == "ip" ]]; then 
    ps1_choice=ps1-ip
else
    ps1_choice=ps1
fi
echo "source $CONFIG_PATH/.$ps1_choice" >> $HOME/.bashrc


# Create necessary paths for custom programs
LOCAL_SRC_PATH="$CONFIG_PATH/src"
LOCAL_BIN_PATH="$CONFIG_PATH/bin"

echo "Creating $LOCAL_SRC_PATH"
mkdir -p "$LOCAL_SRC_PATH"

echo "Creating $LOCAL_BIN_APTH"
mkdir -p "$LOCAL_BIN_PATH"

cp -r ./local/* $HOME/.local

# Apply git aliases
chmod +x git-aliases
./git-aliases

