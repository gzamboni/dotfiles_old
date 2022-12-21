#!/bin/sh

#check if nvim is installed if not then install it depending on the OS
if ! command -v nvim &>/dev/null; then
  if [ "$(uname -s)" = "Darwin" ]; then
    brew install neovim
  elif [ "$(uname -s)" = "Linux" ]; then
    # if this machine is a Debian based distro then use apt-get
    if [ -f /etc/debian_version ]; then
      sudo apt-get install neovim
    # if this machine is a Red Hat based distro then use yum
    elif [ -f /etc/redhat-release ]; then
      sudo yum install neovim
    # if this machine is a Arch based distro then use pacman
    elif [ -f /etc/arch-release ]; then
      sudo pacman -S neovim
    # if this machine is a Gentoo based distro then use emerge
    elif [ -f /etc/gentoo-release ]; then
      sudo emerge neovim
    # if this machine is a SUSE based distro then use zypper
    elif [ -f /etc/SuSE-release ]; then
      sudo zypper install neovim
    # if this machine is a Slackware based distro then use slapt-get
    elif [ -f /etc/slackware-version ]; then
      sudo slapt-get install neovim
    # if this machine is a FreeBSD based distro then use pkg
    elif [ -f /etc/freebsd-version ]; then
      sudo pkg install neovim
    # if this machine is a OpenBSD based distro then use pkg_add
    elif [ -f /etc/openbsd-version ]; then
      sudo pkg_add neovim
    # if this machine is a NetBSD based distro then use pkgin
    elif [ -f /etc/netbsd-version ]; then
      sudo pkgin install neovim
    # if this machine is a DragonFly BSD based distro then use pkg
    elif [ -f /etc/dragonfly-version ]; then
      sudo pkg install neovim
    # if this machine is a Haiku based distro then use pkgman
    elif [ -f /etc/haiku-version ]; then
      sudo pkgman install neovim
    # if this machine is a Alpine based distro then use apk
    elif [ -f /etc/alpine-release ]; then
      sudo apk add neovim
    # if this machine is a NixOS based distro then use nix-env
    elif [ -f /etc/nixos-version ]; then
      sudo nix-env -i neovim
    # if this machine is a GuixSD based distro then use guix package
    elif [ -f /etc/guix-version ]; then
      sudo guix package -i neovim
    # if this machine is a Solus based distro then use eopkg
    elif [ -f /etc/solus-release ]; then
      sudo eopkg install neovim
    # if this machine is a Void based distro then use xbps-install
    elif [ -f /etc/void-release ]; then
      sudo xbps-install neovim
    else
      echo "Your OS is not supported by this script"
    fi
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
if command -v nvim &>/dev/null; then
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
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
