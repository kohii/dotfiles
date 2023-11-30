#!/bin/bash

install_dotfiles() {
	local dotfiles=(.ideavimrc .mackup.cfg .gitconfig .config/nvim Brewfile)
	for file in "${dotfiles[@]}"; do
		if [ -d ~/dotfiles/$file ]; then
			ln -svf ~/dotfiles/$file/ ~/$file
		else
			ln -svf ~/dotfiles/$file ~/$file
		fi
	done
}

install_dotfiles

mackup backup
brew bundle

