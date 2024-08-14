#======================================
# General Settings
#======================================

# Enable colors
autoload -Uz colors && colors

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTTIMEFORMAT="[%Y/%m/%d %H:%M:%S] "

# Completion settings
LISTMAX=1000
WORDCHARS="$WORDCHARS|:"

# Plugin settings
eval "$(sheldon source)"

# Default text editor
export EDITOR=nvim

#======================================
# Options
#======================================

setopt PROMPT_SUBST
setopt AUTO_CD
setopt AUTO_MENU
setopt AUTO_PARAM_KEYS
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt MARK_DIRS
setopt LIST_TYPES
# setopt ALWAYS_LAST_PROMPT
setopt AUTO_PARAM_SLASH
setopt NOTIFY
setopt MAGIC_EQUAL_SUBST
setopt INTERACTIVE_COMMENTS
setopt NO_LIST_BEEP
setopt IGNORE_EOF

#======================================
# Prompt
#======================================

# Customize the prompt
PROMPT="%F{yellow}[%*] %F{cyan}%n@%m %F{green}%(4~|...|)%3~ %F{white}%#%f "
RPROMPT='${vcs_info_msg_0_}'
[[ -n "$SSH_CLIENT" ]] && RPROMPT+=" ⇄" # Add SSH icon if in SSH session

#======================================
# Completion
#======================================

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

#======================================
# VCS Info
#======================================

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

#======================================
# Aliases
#======================================

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

#======================================
# Key Bindings
#======================================

# bindkey '^R' history-incremental-pattern-search-backward
bindkey '^]' peco-src

#======================================
# Functions
#======================================

term() {
  local openPath="./"
  local appPath="/Applications/Kitty.app"
  [[ $# != 0 ]] && openPath="$1"
  open -a $appPath $openPath
}

dotfilesUpdate() {
  (
    cd ~/dotfiles/ || return
    git pull --ff-only
    ./install.sh
  )
}

# peco
peco-src () {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        selected_dir=$(ghq list --full-path --exact $selected_dir)
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src

#======================================
# Third-party Settings
#======================================

# direnv
eval "$(direnv hook zsh)"

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# bun
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# hstr
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

# starship
if [[ $(arch) == 'arm64' ]]; then
  export STARSHIP_SHELL_ARCH=""
else
  export STARSHIP_SHELL_ARCH="x86"
fi

eval "$(starship init zsh)"

# kitty title
precmd () {print -Pn "\e]0;%~\a"}

#======================================
# Local Settings
#======================================

# Import local zshrc if it exists
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local

