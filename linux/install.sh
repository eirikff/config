#! /usr/bin/env bash

function ask_Yn() {
	if [ "${always_yes}" = "true" ]; then
		return 0
	fi 

	read -p "$1 (Y/n) " resp
	if [ -z "${resp}" ]; then
		resp_lc="y"
	else
		resp_lc=$(echo "${resp}" | tr '[:upper:]' '[:lower:]')
	fi

	[ "${resp_lc}" = "y" ]
}

function usage() {
	cat <<EOF
Usage: 
	$0 [--headless] [--yes]

Arguments:
    --headless: install for a headless environment
    --yes: answer yes to all prompts
EOF
}


# Parse arguments
headless=false
always_yes=false
while [ "$#" -gt 0 ]; do
	case "$1" in 
		--headless)
			# Can set with argument or with env
			headless=true
			;;
		--yes)
			always_yes=true
			;;
		*)
			echo "Unknown argument: $1"
			usage
			exit 1
			;;
	esac
	shift
done

if [ "${always_yes}" = "true" ]; then 
	yes_flag="-y"
fi 

# Start install
cat <<EOF
Welcome to eirikff's config installer. This script will interactively install
my preferred environment and configs.

EOF

if [ "${headless}" = "true" ]; then
	echo -e "You are installing in HEADLESS MODE.\n"
fi

if ! ask_Yn "Continue?"; then
	echo "Aborting..."
	exit 0
fi

exit 0

# Install system packages
sudo apt update -qq
if ask_Yn "Upgrade available packages?"; then
	sudo apt upgrade -qq ${yes_flag}
fi

if ask_Yn "Install system packages?"; then
	sudo apt install -qq ${yes_flag} \
		build-essentials \
		cmake \
		git \
		htop \
		tree \
		bat \
		vim \
		nmap \
		screen \
		openvpn \
		python3-pip \
		python3-venv \
		sshfs \
		sshuttle \
		curl \
		zip \
		unzip \
		zsh
fi

if [ "${headless}" = "true" ]; then
	sudo apt install -qq ${yes_flag} \
		openssh-server
else
	sudo apt install -qq ${yes_flag} \
		terminator \
		vlc \
		wireshark \
		x11-apps \
		qbittorrent
fi

if ask_Yn "Install nvim from eirikff/nvim?"; then
	bash <(curl -s https://raw.githubusercontent.com/eirikff/nvim/main/install.sh) --start
fi 
	
# Install docker, zsh, oh-my-zsh, nvim from eirikff/nvim
if ask_Yn "Install docker?"; then

fi 

if [ ! -d "$HOME/.oh-my-zsh" ] && ask_Yn "Install oh-my-zsh?"; then
	args=""
	if ask_Yn "Install oh-my-zsh unattended?"; then
		args="--unattended"
	fi 
	# From https://ohmyz.sh/#install
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) ${args}"
fi 

if ask_Yn "Set zsh as default shell?"; then
	chsh -s "$(which zsh)"
fi 

# Set aliases
# cat = bat

