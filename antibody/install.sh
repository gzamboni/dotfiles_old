#!/bin/sh

#check if antibody is installed if not install it depending on the OS
if command -v antibody >/dev/null 2>&1; then
	echo "antibody is already installed"
else
	if command -v brew >/dev/null 2>&1; then
		brew tap | grep -q 'getantibody/tap' || brew tap getantibody/tap
		brew install antibody
	else
		curl -sL https://git.io/antibody | sudo sh -s -- -b /usr/local/bin
	fi
fi

#check if the antibody cache folder exists if not create it
if [ ! -d "$HOME/.cache/antibody" ]; then
	mkdir -p "$HOME/.cache/antibody"
fi


#install all the plugins
antibody bundle <"$DOTFILES/antibody/bundles.txt" >~/.zsh_plugins.sh

#update all the plugins

antibody update
