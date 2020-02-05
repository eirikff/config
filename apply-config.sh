# Copy vimrc
if [ -f "$HOME/.vimrc" ]
then
    echo ".vimrc exists. Copy manually"
else
    cp vimrc $HOME/.vimrc
fi

# Copy ps1
CONFIG_PATH="$HOME/.config"
if [ ! -d "$CONFIG_PATH" ]
then
    echo "Creating $CONFIG_PATH"
    mkdir -p "$CONFIG_PATH"
fi
cp ps1 $CONFIG_PATH/ps1

# Copy bashrc
if [ -f "$HOME/.bashrc" ]
then
    echo ".bashrc exists. Copy manually"
else
    cp bashrc $HOME/.bashrc
fi


# Create necessary paths for custom programs
LOCAL_SRC_PATH="$HOME/.local/src"
LOCAL_BIN_PATH="$HOME/.local/bin"

if [ ! -d "$LOCAL_SRC_PATH" ]
then
    echo "Creating $LOCAL_SRC_PATH"
    mkdir -p "$LOCAL_SRC_PATH"
fi

if [ ! -d "$LOCAL_BIN_PATH" ]
then
    echo "Creating $LOCAL_BIN_APTH"
    mkdir -p "$LOCAL_BIN_PATH"
fi

cp -r ./local/* $HOME/.local


# Apply git aliases
chmod +x git-aliases
./git-aliases
