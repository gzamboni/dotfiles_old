#!/bin/sh

# Step 1 - check if asdf is installed, if not, install it
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2

# Step 2 - add asdf to the path and install zsh shell integration and completions
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Step 3 - add asdf to .zshrc only if it's not already there
if ! grep -q "asdf" ~/.zshrc; then
	echo ". $HOME/.asdf/asdf.sh" >>~/.zshrc
	echo ". $HOME/.asdf/completions/asdf.bash" >>~/.zshrc
fi

# Step 4 - install plugins
asdf plugin-add direnv
asdf plugin-add nodejs
asdf plugin-add yarn
asdf plugin-add python
asdf plugin-add golang
asdf plugin-add rust

# Step 5 - install nodejs
asdf install nodejs 14.17.0

# Step 6 - install yarn
asdf install yarn 1.22.10

# Step 7 - install python
asdf install python 3.8.15

# Step 8 - install golang
asdf install golang 1.16.6

# Step 9 - install rust
asdf install rust 1.54.0

# Step 10 - install direnv
asdf direnv setup --shell zsh --version latest

# Step 11 - set global versions
asdf global nodejs 14.17.0
asdf global yarn 1.22.10
asdf global python 3.8.15
asdf global golang 1.16.6
asdf global rust 1.54.0
asdf global direnv 2.28.0
