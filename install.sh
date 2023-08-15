#!/bin/bash

install_dotfiles() {
	local dotfiles=(.ideavimrc .mackup.cfg .config/nvim)
	for file in "${dotfiles[@]}"; do
		ln -svf ~/dotfiles/$file ~/$file
	done
}

install_dotfiles

mackup backup

