#!/bin/bash
dotfiles=(.ideavimrc)

for file in "${dotfiles[@]}"; do
        ln -svf ~/dotfiles/$file ~
done
