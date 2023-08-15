#!/bin/bash

install_dotfiles() {
	local dotfiles=(.ideavimrc)
	for file in "${dotfiles[@]}"; do
		ln -svf ~/dotfiles/$file ~
	done
}

install_configs() {
	local src=~/dotfiles/.config/
	local dst=~/.config/

	# ソースディレクトリ内のすべてのファイルとディレクトリに対して繰り返し処理
	find "$src" -type f -or -type d | while read -r file; do
	    # ソースディレクトリの接頭辞を削除してターゲットへのパスを取得
	    target="${dst}${file#$src}"

	    # ターゲットの親ディレクトリを作成（すでに存在する場合はスキップ）
	    mkdir -p "$(dirname "$target")"

	    # シンボリックリンクを作成（すでに存在する場合は上書き）
	    ln -svf "$file" "$target"
	done
}


install_dotfiles
install_configs
