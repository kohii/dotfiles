#!/bin/bash

install_dotfiles() {
	local dotfiles=(.ideavimrc .mackup.cfg .config/nvim)
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

