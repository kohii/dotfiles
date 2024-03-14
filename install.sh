#!/bin/bash

install_dotfiles() {
	local dotfiles=(.ideavimrc .mackup.cfg .gitconfig .gitignore_global .zshrc .config/nvim Brewfile .config/starship.toml)
	for file in "${dotfiles[@]}"; do
		if [ -d ~/dotfiles/$file ]; then
			ln -svf ~/dotfiles/$file/ ~/$file
		else
			ln -svf ~/dotfiles/$file ~/$file
		fi
	done
}

install_dotfiles

chmod +x ./setup.sh
./setup_macos.sh

mackup backup
brew bundle

