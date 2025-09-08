#!/bin/bash
set -euo pipefail

# Remove only symlinks listed in dotfiles.txt from the user's $HOME.

script_dir="$(cd "$(dirname "$0")" && pwd)"
dotfiles_list_file="$script_dir/dotfiles.txt"

usage() {
    echo "Usage: $0 [--dry-run]" >&2
}

dry_run=0
case "${1-}" in
    -n|--dry-run) dry_run=1 ;;
    "") ;;
    *) usage; exit 2 ;;
esac

if [[ ! -f "$dotfiles_list_file" ]]; then
    echo "dotfiles list not found: $dotfiles_list_file" >&2
    exit 1
fi

while IFS= read -r path; do
    [[ -z "$path" ]] && continue
    [[ "$path" =~ ^# ]] && continue

    target="$HOME/$path"
    if [[ -L "$target" ]]; then
        echo "remove symlink: $target"
        if [[ $dry_run -eq 0 ]]; then
            rm -f -- "$target"
        fi
    elif [[ -e "$target" ]]; then
        echo "skip (not a symlink): $target"
    else
        echo "skip (missing): $target"
    fi
done < "$dotfiles_list_file"

exit 0

