# =========================================
# Brewfile
# Apple Silicon macOS setup for development
# =========================================

# -----------------------------------------
# Core CLI / Unix Utilities
# -----------------------------------------
brew "git"                    # Distributed version control
brew "gh"                     # GitHub CLI
brew "jq"                     # JSON processor for CLI
brew "ripgrep"                # Fast recursive grep (rg)
brew "fd"                     # Simple fast find alternative
brew "bat"                    # Cat with syntax highlighting
brew "tree"                   # Directory structure viewer
brew "htop"                   # Interactive process viewer
brew "coreutils"              # GNU core utilities (gdate, etc.)
brew "gnu-sed"                # GNU sed (stream editor)
brew "stow"                   # Symlink farm manager for dotfiles

# -----------------------------------------
# Modern Shell / Terminal Workflow
# -----------------------------------------
brew "mise"                   # Runtime version manager (asdf successor)
brew "starship"               # Minimal fast shell prompt
brew "zoxide"                 # Smarter cd (directory jumper)
brew "fzf"                    # Fuzzy finder for CLI
brew "direnv"                 # Per-directory env loader
brew "eza"                    # Modern ls replacement
brew "lazygit"                # Terminal UI for git
brew "tmux"                   # Terminal multiplexer
brew "neovim"                 # Vim-fork text editor

# -----------------------------------------
# Cloud / Platform CLIs
# -----------------------------------------
# Tier 3 (e.g. newer macOS) has no bottle; build from source when needed
brew "awscli", args: ["build-from-source"]  # Amazon Web Services CLI
brew "azure-cli"                            # Microsoft Azure CLI
cask "gcloud-cli"                           # Google Cloud SDK
brew "snowflake-cli"                        # Snowflake data platform CLI (snow)

# -----------------------------------------
# PHP (mise asdf-php often fails on macOS; use Homebrew for reliable install)
# -----------------------------------------
brew "php"                    # PHP runtime
brew "composer"               # PHP dependency manager

# -----------------------------------------
# Desktop Apps - Browsers
# -----------------------------------------
cask "arc"                    # Chromium-based browser by The Browser Company

# -----------------------------------------
# Desktop Apps - Productivity / Window Mgmt
# -----------------------------------------
cask "raycast"                # Launcher, shortcuts, and automation
cask "rectangle"              # Window management (snap/resize)
cask "alt-tab"                # Windows-style Alt+Tab switcher
cask "stats"                  # Menu bar system monitor (CPU, RAM, network)

# -----------------------------------------
# Desktop Apps - AI / Development
# -----------------------------------------
cask "chatgpt"                # OpenAI ChatGPT desktop app
cask "cursor"                 # AI-powered code editor
cask "cursor-cli"             # Cursor terminal agent (cursor-agent)
cask "visual-studio-code"     # VS Code editor
cask "iterm2"                 # Terminal emulator for macOS
cask "orbstack"               # Lightweight Docker & Linux VMs
brew "podman"                 # Daemonless container engine and CLI
cask "postman"                # API development and testing
cask "codex-app"              # Codex AI coding assistant
cask "claude"                 # Anthropic Claude desktop app
cask "claude-code"            # Claude AI coding assistant


# -----------------------------------------
# Desktop Apps - Writing / Language / Notes
# -----------------------------------------
cask "grammarly-desktop"      # Writing assistant and grammar checker
cask "deepl"                  # Translation app (DeepL)
cask "obsidian"               # Markdown-based note-taking and knowledge base
cask "descript"               # Podcast/video editor with transcription

# -----------------------------------------
# Desktop Apps - Utilities
# -----------------------------------------
cask "the-unarchiver"         # Archive extractor (zip, rar, 7z, etc.)
cask "vlc"                    # Media player for video/audio
cask "elgato-camera-hub"      # Webcam control app for Elgato devices
