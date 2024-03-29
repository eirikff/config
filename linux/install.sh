#!/usr/bin/env bash

function green() {
	local string="$@"
	echo -e "\e[32m${string}\e[0m"
}

function ask_Yn() {
	if [ "${always_yes}" = "true" ]; then
		return 0
	fi 

	local prompt="$1 (Y/n) "
	read -p "$(green "${prompt}")" resp
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
else
	echo -e "You are installing in NORMAL MODE.\n"
fi

if ! ask_Yn "Continue?"; then
	echo "Aborting..."
	exit 0
fi

mkdir -p $HOME/.local/bin

# Install system packages
sudo apt update 
if ask_Yn "Upgrade available packages (recommended)?"; then
	sudo apt upgrade -y
fi

if ask_Yn "Install system packages?"; then
	sudo apt install -y \
		build-essential \
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
		zsh \
		p7zip-full \
		fdisk \
		gdb \
		jq

	# necessary symlink for batcat -> bat
	ln -s $(which batcat) $HOME/.local/bin/bat

	if [ "${headless}" = "true" ]; then
		sudo apt install -y \
			openssh-server
	else
		sudo apt install -y \
			terminator \
			vlc \
			wireshark \
			x11-apps \
			qbittorrent
	fi
fi

if ask_Yn "Install nvim from eirikff/nvim?"; then
	bash <(curl -s https://raw.githubusercontent.com/eirikff/nvim/main/install.sh) --start
fi 
	
if ask_Yn "Install docker?"; then
	# Install commands from 
	# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
	if [ ! -f "/etc/apt/keyrings/docker.asc" ]; then
		sudo apt-get install -y ca-certificates curl
		sudo install -m 0755 -d /etc/apt/keyrings
		sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
			-o /etc/apt/keyrings/docker.asc
		sudo chmod a+r /etc/apt/keyrings/docker.asc
	fi

	# Add the repository to Apt sources:
	if [ ! -f "/etc/apt/sources.list.d/docker.list" ]; then
		echo \
		  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
		  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
		  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		sudo apt-get update
	fi

	sudo apt-get install -y \
		docker-ce \
		docker-ce-cli \
		containerd.io \
		docker-buildx-plugin \
		docker-compose-plugin
fi 

if [ ! -d "$HOME/.oh-my-zsh" ] && ask_Yn "Install oh-my-zsh?"; then
	args=""
	if ask_Yn "Install oh-my-zsh unattended?"; then
		args="--unattended"
	fi 
	# From https://ohmyz.sh/#install
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) ${args}"
fi 

if ask_Yn "Set zsh as default login shell?"; then
	chsh -s "$(which zsh)"
fi 

if ask_Yn "Install dotfiles from eirikff/config?"; then
	if ask_Yn "Use SSH repo link?"; then
		config_repo="git@github.com:eirikff/config.git"
	else
		config_repo="https://github.com/eirikff/config.git"
	fi
	green "Using repo link: ${config_repo}"

	config_target="$HOME/.config/eirikff"
	if [ -d ${config_target} ]; then
		pushd ${config_target} &>/dev/null
		(git pull && git checkout master) &>/dev/null
		popd &>/dev/null
	else
		git clone ${config_repo} "${config_target}"
	fi

	# create symlinks for some config files
	dotfile_base="${config_target}/linux"
	if [ ! -f "$HOME/.vimrc" ]; then
		ln -s "${dotfile_base}/.vimrc" "$HOME/.vimrc" && \
		echo "Symlinked .vimrc"
	fi

	# add source statements to rc files
	files_to_source=( 
		"aliases.sh"
		"environment.sh"
		"path.sh"
		"wsl.sh"
	)
	for rc_file in ".bashrc" ".zshrc"; do
		rc_path="$HOME/${rc_file}"
		if [ ! -f "${rc_path}" ]; then
			continue
		fi

		for file in "${files_to_source[@]}"; do
			file_path="${dotfile_base}/${file}"

			line="source ${file_path}"
			if ! grep -e "${line}" "${rc_path}" &>/dev/null; then
				echo "${line}" >> ${rc_path}
			fi
		done
	done

	# Add plugins=(...) just before source
	zsh_plugsin=(
		"git"
		"colored-man-pages"
		"zsh-syntax-highlighting"  # must be the last plugin sourced
	)
	plugins_array_str="plugins=("
	for plugin in "${zsh_plugsin[@]}"; do 
		plugins_array_str+="${plugin} "
	done
	plugins_array_str+=")"
	sed -i "/^source \$ZSH\/oh-my-zsh.sh/i ${plugins_array_str}" "$HOME/.zshrc"

	if ask_Yn "Set Git config?"; then
		git_base="${dotfile_base}/git"
		${git_base}/git-aliases.sh
		${git_base}/git-editor.sh
		${git_base}/git-lg.sh

		if ask_Yn "Set GitHub anonymous email?"; then
			${git_base}/github-anon-email.sh
		fi
	fi
fi

