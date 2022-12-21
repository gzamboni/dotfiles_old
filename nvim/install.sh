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

#check if the symlink exists if not then create it
if [ ! -d ~/.config/nvim ]; then
  ln -s ~/.dotfiles/nvim ~/.config/nvim
fi

# check if Packer plugin manager is installed if not then install it
if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# if nvim is installed then install nvim plugins
if ! command -v nvim &>/dev/null; then
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' &>/dev/null
fi

# search for the EDITOR variable in .zshrc if it exists and replace it with nvim
# if not then append it with nvim value to the end of the file
if grep -q "EDITOR" ~/.zshrc; then
  # if this machine is a Mac then use sed -i '' instead of sed -i
  if [ "$(uname -s)" = "Darwin" ]; then
    mv ~/.zshrc ~/zshrc.bak
    sed -i '' 's/EDITOR=.*/EDITOR=nvim/g' ~/zshrc.bak
    mv ~/zshrc.bak ~/.zshrc
  else
    mv ~/.zshrc ~/zshrc.bak
    sed -i 's/EDITOR=.*/EDITOR=nvim/g' ~/zshrc.bak
    mv ~/zshrc.bak ~/.zshrc
  fi
else
  echo "EDITOR=nvim" >>~/.zshrc
fi
