#!/bin/sh
if command -v brew >/dev/null 2>&1; then
	brew install asdf
else
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
fi
echo "source $HOME/.asdf/asdf.sh" >>~/.zshrc
# append completions to fpath
echo "fpath=(\${ASDF_DIR}/completions \$fpath)" >>~/.zshrc
# initialise completions with ZSH's compinit
echo "autoload -Uz compinit && compinit" >>~/.zshrc
