# Native Apple Silicon Homebrew path
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS

# Shell behavior
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt EXTENDED_GLOB

# Completion
autoload -Uz compinit
compinit

# Prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Runtime manager
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# Smarter directory jumping
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Fuzzy finder shell integration
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# Aliases
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --color=auto --group-directories-first"
  alias ll="eza -lah --git --group-directories-first"
  alias la="eza -a --group-directories-first"
  alias lt="eza --tree --level=2 --group-directories-first"
else
  alias ls="ls -G"
  alias ll="ls -lah"
  alias la="ls -A"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat --paging=never"
fi

alias c="clear"
alias ..="cd .."
alias ...="cd ../.."

alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gca="git commit -a"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"

# Use zoxide as your default cd if available
if command -v z >/dev/null 2>&1; then
  alias cd="z"
fi

# Local machine-only config
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Cortex CLI completion (disable via /settings in cortex)
[[ -s ~/.zsh/completions/cortex.zsh ]] && source ~/.zsh/completions/cortex.zsh

# Added by the Cortex Code installer.
export PATH="/Users/masaki_kumamoto/.local/bin:$PATH"
