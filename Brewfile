# =========================================
# Brewfile
# Modern macOS setup for development
# =========================================

# -----------------------------------------
# Core CLI / Unix Utilities
# -----------------------------------------
brew "git"
brew "gh"
brew "jq"
brew "ripgrep"
brew "fd"
brew "bat"
brew "tree"
brew "htop"
brew "coreutils"
brew "gnu-sed"
brew "stow"

# -----------------------------------------
# Modern Shell / Terminal Workflow
# -----------------------------------------
brew "mise"
brew "starship"
brew "zoxide"
brew "fzf"
brew "direnv"
brew "eza"
brew "lazygit"
brew "tmux"
brew "neovim"

# -----------------------------------------
# Cloud / Platform CLIs
# -----------------------------------------
# Tier 3 (e.g. newer macOS) has no bottle; build from source when needed
brew "awscli", args: ["build-from-source"]
brew "azure-cli"
cask "gcloud-cli"

# -----------------------------------------
# PHP (mise asdf-php often fails on macOS; use Homebrew for reliable install)
# -----------------------------------------
brew "php"
brew "composer"

# -----------------------------------------
# Desktop Apps - Browsers
# -----------------------------------------
cask "arc"

# -----------------------------------------
# Desktop Apps - Productivity / Window Mgmt
# -----------------------------------------
cask "raycast"
cask "rectangle"
cask "alt-tab"
cask "stats"

# -----------------------------------------
# Desktop Apps - AI / Development
# -----------------------------------------
cask "chatgpt"
cask "cursor"
cask "visual-studio-code"
cask "iterm2"
cask "orbstack"
cask "postman"
cask "codex-app"
cask "claude-code"


# -----------------------------------------
# Desktop Apps - Writing / Language / Notes
# -----------------------------------------
cask "grammarly-desktop"
cask "deepl"
cask "obsidian"

# -----------------------------------------
# Desktop Apps - Utilities
# -----------------------------------------
cask "the-unarchiver"
cask "vlc"