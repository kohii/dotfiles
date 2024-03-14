#!/bin/bash

dotfiles_dir=~/dotfiles
dotfiles_list_file=~/dotfiles/dotfiles.txt

create_symlink() {
    local source=$1
    local target=$2

    if [ -e "$target" ]; then
        if [ -L "$target" ]; then
            ln -svf "$source" "$target"
        else
            echo "Error: $target already exists and is not a symlink."
        fi
    else
        ln -sv "$source" "$target"
    fi
}

install_dotfiles() {
    while IFS= read -r file; do
        source="$dotfiles_dir/$file"
        target="$HOME/$file"

        if [ -d "$source" ]; then
            create_symlink "$source/" "$target"
        else
            create_symlink "$source" "$target"
        fi
    done < "$dotfiles_list_file"
}

if [ -f "$dotfiles_list_file" ]; then
    install_dotfiles
else
    echo "Error: $dotfiles_list_file not found."
    exit 1
fi

chmod +x ./configure_macos.sh
./configure_macos.sh

mackup backup
brew bundle

