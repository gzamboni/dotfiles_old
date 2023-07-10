# This script will install helix editor on your system

# This script is meant for unix systems only
# This script is meant for zsh only

# check if helix-editor is installed if not install it

if command -v helix &> /dev/null; then
	exit 0
fi

# check if this system is a MacOs system
if [[ "$OSTYPE" == "darwin"* ]]; then
	echo "This is a MacOs system"
	brew install helix
else
	# check if this system is a Linux system
	# and depends on the package manager install helix editor
	# if the package manager is not supported then exit the script
	# with an error message

	if [[ -f /etc/os-release ]]; then
		# freedesktop.org and systemd
		. /etc/os-release
		OS=$NAME
		VER=$VERSION_ID
	elif type lsb_release >/dev/null 2>&1; then
		# linuxbase.org
		OS=$(lsb_release -si)
		VER=$(lsb_release -sr)
	elif [ -f /etc/lsb-release ]; then
		# For some versions of Debian/Ubuntu without lsb_release command
		. /etc/lsb-release
		OS=$DISTRIB_ID
		VER=$DISTRIB_RELEASE
	elif [ -f /etc/debian_version ]; then
		# Older Debian/Ubuntu/etc.
		OS=Debian
		VER=$(cat /etc/debian_version)
	elif [ -f /etc/SuSe-release ]; then
		# Older SuSE/etc.
		...
	elif [ -f /etc/redhat-release ]; then
		# Older Red Hat, CentOS, etc.
		...
	else
		# Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
		OS=$(uname -s)
		VER=$(uname -r)
	fi

	if [[ "$OS" == "Ubuntu" ]]; then
		sudo apt install helix
	elif [[ "$OS" == "Arch Linux" ]]; then
		sudo pacman -S helix
	elif [[ "$OS" == "Fedora" ]]; then
		sudo dnf copr enable varlad/helix
		sudo dnf install helix
	elif [[ "$OS" == "Debian" ]]; then
		sudo apt install helix
	else
		echo "Your system is not supported"
		exit 1
	fi
fi

exit 0
