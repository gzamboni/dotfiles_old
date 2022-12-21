#!/bin/sh

# check if asdf is installed, if not, install it
if command -v asdf >/dev/null 2>&1; then
	echo "asdf is already installed"
else
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
	# add asdf to the path and install zsh shell integration and completions
	. $HOME/.asdf/asdf.sh
	. $HOME/.asdf/completions/asdf.bash
fi

# install plugins
PLUGINS=(
	"direnv"
	"nodejs"
	"yarn"
	"python"
	"golang"
	"rust"
	"terraform"
)

for plugin in "${PLUGINS[@]}"; do
	# check if plugin is installed, if not, install it
	if asdf plugin-list | grep -q "$plugin"; then
		echo "$plugin is already installed"
	else
		asdf plugin-add "$plugin"
	fi
done

# install direnv
asdf install direnv 2.28.0

# install nodejs
asdf install nodejs 19.3.0

# install yarn
asdf install yarn 1.22.10

# install python
asdf install python 3.8.15

# install golang
asdf install golang 1.16.6

# install rust
asdf install rust 1.54.0

# install terraform
asdf install terraform latest

# set global versions
asdf global nodejs 19.3.0
asdf global yarn 1.22.10
asdf global python 3.8.15
asdf global golang 1.16.6
asdf global rust 1.54.0
asdf global direnv 2.28.0
asdf global terraform latest

# add asdf to .zshrc only if it's not already there
if ! grep -q "asdf" ~/.zshrc; then
	echo ". $HOME/.asdf/asdf.sh" >>~/.zshrc
	echo ". $HOME/.asdf/completions/asdf.bash" >>~/.zshrc
	#  install direnv
	asdf direnv setup --shell zsh --version latest
fi
