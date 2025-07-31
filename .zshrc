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

alias claude="~/.claude/local/claude"
alias yolo='claude --dangerously-skip-permissions'

#======================================
# Key Bindings
#======================================

# bindkey '^R' history-incremental-pattern-search-backward
bindkey '^]' peco-src
bindkey '^W' peco-worktree
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

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

ghwatch() {
  local input="$1"

  if [ -z "$input" ]; then
    echo "Usage: ghwatch <run-id or GitHub Actions URL>"
    return 1
  fi

  # Extract run-id from URL if provided
  if [[ "$input" =~ /actions/runs/([0-9]+) ]]; then
    local run_id="${match[1]}"
  else
    local run_id="$input"
  fi

  echo "🔍 Watching workflow: $run_id"
  if gh run watch "$run_id" --exit-status; then
    osascript -e 'display notification "Workflow completed ✅" with title "GitHub Actions"'
  else
    osascript -e 'display notification "Workflow failed ❌" with title "GitHub Actions"'
  fi
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

# peco worktree switcher
peco-worktree () {
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Not in a git repository"
        zle clear-screen
        return 1
    fi
    
    # Get list of worktrees with formatted output for peco
    local worktree_list=$(git worktree list --porcelain | awk '
        /^worktree / { path = substr($0, 10) }
        /^branch / { branch = substr($0, 8) }
        /^HEAD / { branch = "HEAD" }
        /^$/ { 
            if (path != "") {
                if (branch == "") branch = "(bare)"
                printf "%s [%s]\n", path, branch
                path = ""
                branch = ""
            }
        }
        END {
            if (path != "") {
                if (branch == "") branch = "(bare)"
                printf "%s [%s]\n", path, branch
            }
        }
    ')
    
    # Use peco to select a worktree
    local selected_worktree=$(echo "$worktree_list" | peco --query "$LBUFFER")
    
    if [ -n "$selected_worktree" ]; then
        # Extract the path (everything before the last [branch])
        local selected_path=$(echo "$selected_worktree" | sed 's/ \[[^]]*\]$//')
        BUFFER="cd \"${selected_path}\""
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-worktree

# peco worktree delete - select and remove worktree with git wtd
gwtd () {
    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "Not in a git repository"
        return 1
    fi
    
    # Get list of worktrees with formatted output for peco (excluding main worktree)
    local worktree_list=$(git worktree list --porcelain | awk '
        /^worktree / { path = substr($0, 10) }
        /^branch / { branch = substr($0, 8) }
        /^HEAD / { branch = "HEAD" }
        /^bare / { is_bare = 1 }
        /^$/ { 
            if (path != "" && !is_bare && branch != "HEAD") {
                if (branch == "") branch = "(detached)"
                printf "%s [%s]\n", path, branch
            }
            path = ""
            branch = ""
            is_bare = 0
        }
        END {
            if (path != "" && !is_bare && branch != "HEAD") {
                if (branch == "") branch = "(detached)"
                printf "%s [%s]\n", path, branch
            }
        }
    ')
    
    if [ -z "$worktree_list" ]; then
        echo "No worktrees available to delete"
        return 1
    fi
    
    # Use peco to select a worktree to delete
    local selected_worktree=$(echo "$worktree_list" | peco --prompt="Select worktree to delete: ")
    
    if [ -n "$selected_worktree" ]; then
        # Extract the branch name (everything between [ and ])
        local branch_name=$(echo "$selected_worktree" | sed -n 's/.*\[\(.*\)\]$/\1/p')
        
        # Remove refs/heads/ prefix if present
        branch_name=$(echo "$branch_name" | sed 's|^refs/heads/||')
        
        if [ -n "$branch_name" ] && [ "$branch_name" != "(detached)" ]; then
            echo "Deleting worktree for branch: $branch_name"
            git wtd "$branch_name"
        else
            echo "Cannot delete detached or invalid worktree"
        fi
    fi
}

#======================================
# Third-party Settings
#======================================

# direnv
eval "$(direnv hook zsh)"

# Register shell hook for mise
eval "$(mise activate zsh)"

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# bun
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
## bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# hstr
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

# sccache for rust
export RUSTC_WRAPPER=$(which sccache)
export SCCACHE_CACHE_SIZE="10G"
export SCCACHE_DIR="$HOME/.cache/sccache"

# Created by `pipx` on 2025-04-13 02:56:45
export PATH="$PATH:/Users/kohei/.local/bin"

# starship
if [[ $(arch) == 'arm64' ]]; then
  export STARSHIP_SHELL_ARCH=""
else
  export STARSHIP_SHELL_ARCH="x86"
fi

eval "$(starship init zsh)"

# kitty title
precmd () {print -Pn "\e]0;%~\a"}

# disable cloudflare telemetry
export CREATE_CLOUDFLARE_TELEMETRY_DISABLED=1

# disable turbo telemetry
export TURBO_TELEMETRY_DISABLED=1

#======================================
# Local Settings
#======================================

# Import local zshrc if it exists
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local


