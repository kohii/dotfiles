#!/bin/bash

dotfiles_dir=~/dotfiles
dotfiles_list_file=~/dotfiles/dotfiles.txt

create_symlink() {
    local source=$1
    local target=$2

    if [ -e "$target" ]; then
        if [ -L "$target" ]; then
            if [ "$(readlink -- "$target")" = "$source" ]; then
                echo "The symlink $target already points to $source."
            else
                ln -snfv "$source" "$target"
            fi
        else
            echo "Error: $target already exists and is not a symlink."
        fi
    else
        ln -snv "$source" "$target"
    fi
}

install_dotfiles() {
    while IFS= read -r file; do
        source="$dotfiles_dir/$file"
        target="$HOME/$file"
        create_symlink "$source" "$target"
    done < "$dotfiles_list_file"
}

load_launchctl_job() {
    local plist_file="$1"
    local target="$HOME/Library/LaunchAgents/$plist_file"

    local job_name=$(echo "$plist_file" | sed 's/\.plist$//')

    if launchctl list | awk '{print $3}' | grep -q "$job_name"; then
        echo "$job_name is already loaded"
    else
        launchctl load "$target"
    fi
}

install_launchd() {
    files=("tokyo.kohii.gitfetch.plist")
    for file in "${files[@]}"; do
        source="$dotfiles_dir/launchd/$file"
        target="$HOME/Library/LaunchAgents/$file"
        create_symlink "$source" "$target"
        load_launchctl_job "$file"
    done
}

if [ -f "$dotfiles_list_file" ]; then
    install_dotfiles
else
    echo "Error: $dotfiles_list_file not found."
    exit 1
fi

install_launchd

chmod +x ./configure_macos.sh
./configure_macos.sh

mackup backup
brew bundle

