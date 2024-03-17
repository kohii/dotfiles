# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
########################################
# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

#ヒストリの一覧を読みやすい形に変更
HISTTIMEFORMAT="[%Y/%M/%D %H:%M:%S] "

#補完リストが多いときに尋ねない
LISTMAX=1000

#"|,:"を単語の一部とみなさない
WORDCHARS="$WORDCHARS|:"


# プロンプト
if [[ -e /usr/share/zsh/site-contrib/powerline.zsh ]]; then
	# Powerline support is enabled if available, otherwise use a regular PS1
	. /usr/share/zsh/site-contrib/powerline.zsh
	VIRTUAL_ENV_DISABLE_PROMPT=true
else
	# Default colors:
	# Cyan for users, red for root, magenta for system users
	local _time="%{$fg[yellow]%}[%*]"
	local _path="%B%{$fg[green]%}%(4~|...|)%3~"
	local _usercol
	if [[ $EUID -lt 1000 ]]; then
		# red for root, magenta for system users
		_usercol="%(!.%{$fg[red]%}.%{$fg[magenta]%})"
	else
		_usercol="$fg[cyan]"
	fi
	local _user="%{$_usercol%}%n@%m"
	local _prompt="%{$fg[white]%}${(r:$SHLVL*2::%#:)}"

	PROMPT="$_time $_user $_path $_prompt%b%f%k "

	RPROMPT='${vcs_info_msg_0_}' # git branch
	if [[ ! -z "$SSH_CLIENT" ]]; then
		RPROMPT="$RPROMPT ⇄" # ssh icon
	fi
fi

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


########################################
# オプション

#http://www.ayu.ics.keio.ac.jp/~mukai/translate/zshoptions.html
#タブキーの連打で自動的にメニュー補完
setopt AUTO_MENU
#/foo/barでいきなりcd
setopt AUTO_CD
#"~$var" でディレクトリにアクセス
setopt AUTO_NAME_DIRS
#補完が/で終って、つぎが、語分割子か/かコマンドの後(;とか&)だったら、補完末尾の/を取る
unsetopt AUTO_REMOVE_SLASH
#曖昧な補完で、自動的に選択肢をリストアップ
setopt AUTO_LIST
#変数名を補完する
setopt AUTO_PARAM_KEYS
#プロンプト文字列で各種展開を行なう
setopt PROMPT_SUBST
# サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt AUTO_RESUME
#rm * などの際確認しない
setopt RM_STAR_SILENT
#ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt MARK_DIRS
#明確なドットの指定なしで.から始まるファイルをマッチ
setopt GLOBDOTS
#rm *で確認
setopt RM_STAR_WAIT
#行の末尾がバッククォートでも無視する
setopt SUN_KEYBOARD_HACK
#~hoge以外にマッチする機能を使わない
setopt EXTENDED_GLOB
#補完対象のファイルの末尾に識別マークをつける
setopt LIST_TYPES
#BEEPを鳴らさない
setopt NO_BEEP
#補完候補など表示する時はその場に表示し、終了時に画面から消す
setopt ALWAYS_LAST_PROMPT
#cd kotaで/home/kotaに移動する
setopt CDABLE_VARS
#クォートされていない変数拡張が行われたあとで、フィールド分割
setopt SH_WORD_SPLIT
#定義された全ての変数は自動的にexportする
setopt ALL_EXPORT
#ディレクトリ名を補完すると、末尾がスラッシュになる。
setopt AUTO_PARAM_SLASH
#普通のcdでもスタックに入れる
setopt AUTO_PUSHD
#コマンドのスペルの訂正を使用する
setopt CORRECT
#引数のスペルの訂正を使用する
unsetopt CORRECT_ALL
#aliasを展開して補完
unsetopt COMPLETE_ALIASES
#"*" にドットファイルをマッチ
unsetopt GLOB_DOTS
#補完候補を詰めて表示
setopt LIST_PACKED
#ディレクトリスタックに、同じディレクトリを入れない
setopt PUSHD_IGNORE_DUPS
#移動履歴をキューではなくスタックで番号付け(最近居た場所が上になる)
setopt PUSHD_MINUS
#^Dでログアウトしないようにする
unsetopt IGNORE_EOF
#ジョブの状態をただちに知らせる
setopt NOTIFY
#複数のリダイレクトやパイプに対応
setopt MULTIOS
#ファイル名を数値的にソート
setopt NUMERIC_GLOB_SORT
#リダイレクトで上書き禁止
unsetopt NOCLOBBER
#=以降でも補完できるようにする
setopt MAGIC_EQUAL_SUBST
#補完候補リストの日本語を正しく表示
setopt PRINT_EIGHT_BIT
#右プロンプトに入力がきたら消す
setopt TRANSIENT_RPROMPT
#戻り値が0以外の場合終了コードを表示
unsetopt PRINT_EXIT_VALUE
#echo {a-z}などを使えるようにする
setopt BRACE_CCL
#!!などを実行する前に確認する
setopt HISTVERIFY
#余分な空白は詰めて記録
setopt HIST_IGNORE_SPACE
#ヒストリファイルを上書きするのではなく、追加するようにする
setopt APPEND_HISTORY
#ジョブがあっても黙って終了する
setopt NO_CHECK_JOBS
#ヒストリに時刻情報もつける
setopt EXTENDED_HISTORY
#履歴がいっぱいの時は最も古いものを先ず削除
setopt HIST_EXPIRE_DUPS_FIRST
#履歴検索中、重複を飛ばす
setopt HIST_FIND_NO_DUPS
#ヒストリリストから関数定義を除く
unsetopt HIST_NO_FUNCTIONS
#前のコマンドと同じならヒストリに入れない
setopt HIST_IGNORE_DUPS
#重複するヒストリを持たない
setopt HIST_IGNORE_ALL_DUPS
#実行するまえに必ず展開結果を確認できるようにする
setopt HIST_VERIFY
#履歴をインクリメンタルに追加
setopt INC_APPEND_HISTORY
#history コマンドをヒストリに入れない
unsetopt HIST_NO_STORE
#履歴から冗長な空白を除く
setopt HIST_REDUCE_BLANKS
#履歴を共有
setopt SHARE_HISTORY
# 古いコマンドと同じものは無視
setopt HIST_SAVE_NO_DUPS
#補完時にヒストリを自動的に展開する
setopt HIST_EXPAND
#改行コードで終らない出力もちゃんと出力する
setopt NO_PROMPTCR
#loop の短縮形を許す
setopt SHORT_LOOPS
#コマンドラインがどのように展開され実行されたかを表示する
unsetopt XTRACE
#シンボリックリンクは実体を追うようになる
unsetopt CHASE_LINKS
#$0 にスクリプト名/シェル関数名を格納
setopt FUNCTION_ARGZERO
#Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_FLOW_CONTROL
#コマンドラインでも # 以降をコメントと見なす
setopt INTERACTIVE_COMMENTS
#デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる
unsetopt SINGLE_LINE_ZLE
#語の途中でもカーソル位置で補完
setopt COMPLETE_IN_WORD
#**で**/*と同じ意味になる >5.2
#setopt GLOB_STAR_SHORT

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias ls='lsd'
alias ll='lsd -l'
alias la='lsd -la'
alias lt='lsd --tree'

alias vi=nvim
alias grep='grep --color=auto'
alias x86='arch -x86_64 zsh' 
alias relogin='exec $SHELL -l'
alias teee='tee >(pbcopy)'

alias python=python3
alias pip=pip3

########################################
function iterm() {
  local openPath="./"
  local appPath="/Applications/iTerm.app"
  if [ $# != 0 ]; then
    openPath="$1"
  fi
  open -a $appPath $openPath
}

function dotfilesUpdate() {
  cd ~/dotfiles/
  git pull --ff-only
  ./install.sh
  cd -
}
########################################

# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)


########################################

#export PATH="$HOME/.anyenv/bin:$PATH"
#
#eval "$(anyenv init -)"
#export PATH="$HOME/.jenv/bin:$PATH"
#eval "$(jenv init -)"

eval "$(direnv hook zsh)"

export DENO_INSTALL="~/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Import local zshrc if it exists
if [[ -f ~/.zshrc_local ]]; then
  source ~/.zshrc_local
fi

if [[ $(arch) == 'arm64' ]]; then
  export STARSHIP_SHELL_ARCH=""
else
  export STARSHIP_SHELL_ARCH="x86"
fi

eval "$(starship init zsh)"


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
