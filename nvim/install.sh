#!/bin/sh

#check if nvim is installed if not then install it depending on the OS
if ! command -v nvim &>/dev/null; then
  if command -v apt &>/dev/null; then
    sudo apt install -y neovim
  elif command -v pacman &>/dev/null; then
    sudo pacman -S neovim
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y neovim
  elif command -v yum &>/dev/null; then
    sudo yum install -y neovim
  elif command -v zypper &>/dev/null; then
    sudo zypper install -y neovim
  elif command -v brew &>/dev/null; then
    brew install neovim
  else
    echo "nvim is not installed and I don't know how to install it on your OS"
    exit 1
  fi
fi
# links nvim config to dotfiles
ln -s ~/.dotfiles/nvim ~/.config/nvim

# install Packer vim plugin manager
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# install plugins
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' &>/dev/null

# search for the EDITOR variable in .zshrc if it exists and replace it with nvim
# if not then append it with nvim value to the end of the file
if grep -q "EDITOR" ~/.zshrc; then
  sed -i 's/EDITOR=.*/EDITOR=nvim/g' ~/.zshrc
else
  echo "EDITOR=nvim" >>~/.zshrc
fi
