# Dotfiles

A **dotfiles** repo is where you keep your shell config, editor settings, and tool preferences so you can set up a new Mac (or reinstall) in one go. This one targets **macOS** and gives you a modern development environment: runtimes, CLI tools, and desktop apps.

---

## What You Get

| Area | What's configured |
|------|-------------------|
| **Shell** | Zsh with history, completion, and safe defaults |
| **Prompt** | [Starship](https://starship.rs/) — shows directory, git branch, and runtime versions (Node, Python, Go, Rust, etc.) |
| **Runtimes** | [mise](https://mise.jdx.dev/) manages Node, Python, Go, Rust, Java, .NET, Ruby, Terraform, and more (versions defined in one file) |
| **CLI tools** | git, gh, ripgrep, fd, bat, eza, fzf, zoxide, neovim, lazygit, tmux, direnv, and others via Homebrew |
| **Cloud CLIs** | AWS, Azure, Google Cloud (via Homebrew/Cask) |
| **Global npm/pnpm tools** | Claude CLIs, Gemini CLI, Codex, etc. (see `pnpm/globals.txt`) |
| **Git** | Sensible defaults and your name/email (you should edit these) |
| **Desktop apps** | Arc, Raycast, Rectangle, Cursor, VS Code, iTerm2, OrbStack, Postman, and more (optional; all in `Brewfile`) |

Everything is driven by a single **bootstrap script** that installs packages and links config files into your home directory.

---

## Prerequisites

- **macOS** (Apple Silicon or Intel)
- **Homebrew** — if you don’t have it:
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
  Then follow the “Next steps” it prints (adding Homebrew to your `PATH`).

---

## Quick Start

1. **Clone this repo** (replace with your own fork or path if you use one):
   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Edit your Git identity** in `git/.gitconfig` (name and email). The bootstrap will link this file to `~/.gitconfig`.

3. **Run the bootstrap**:
   ```bash
   ./scripts/bootstrap.sh
   ```

4. **Restart your shell** so all tools and config are loaded:
   ```bash
   exec zsh
   ```

That’s it. The script will install everything from the Brewfile, link dotfiles, install mise runtimes, and install global pnpm packages.

---

## What the Bootstrap Does (In Order)

1. **`install_brew_bundle`** — Installs everything in `Brewfile` (CLI tools, casks like Cursor/VS Code, etc.). Requires Homebrew.
2. **`link_dotfiles`** — Creates symlinks from this repo into your home directory:
   - `git/.gitconfig` → `~/.gitconfig`
   - `zsh/.zshrc` → `~/.zshrc`
   - `starship/.config/starship.toml` → `~/.config/starship.toml`
   - `mise/.config/mise/config.toml` → `~/.config/mise/config.toml`  
   If a file already exists, it’s backed up with a timestamp (e.g. `~/.zshrc.bak.20260306120000`).
3. **`install_mise_tools`** — Runs `mise install` so all runtimes in `mise/.config/mise/config.toml` are installed (Node, Python, Go, etc.).
4. **`install_pnpm_globals`** — Installs the packages listed in `pnpm/globals.txt` with `pnpm add -g`.
5. **`post_checks`** — Prints versions of brew, mise, starship, and git so you can confirm things work.

---

## Repo Structure

```
dotfiles/
├── README.md                 # This file
├── Brewfile                  # Homebrew formulae and casks (brew bundle)
├── git/
│   └── .gitconfig            # Git user name, email, and defaults
├── mise/
│   └── .config/mise/
│       └── config.toml       # Runtime versions (Node, Python, Go, etc.)
├── pnpm/
│   └── globals.txt           # Global pnpm packages (one per line)
├── scripts/
│   └── bootstrap.sh          # One-shot setup script
├── starship/
│   └── .config/starship.toml # Prompt theme and segments
└── zsh/
    └── .zshrc                # Zsh config, aliases, starship/mise/zoxide/fzf
```

---

## Customization

- **Git name/email** — Edit `git/.gitconfig` before (or after) running the bootstrap. Only you should change these.
- **Shell-only overrides** — Create `~/.zshrc.local`. It’s sourced at the end of `.zshrc` if it exists. Use it for machine-specific aliases or keys; don’t commit secrets.
- **Add/remove Homebrew packages** — Edit `Brewfile`, then run `brew bundle --file=~/dotfiles/Brewfile` (or run the bootstrap again).
- **Add/remove runtimes** — Edit `mise/.config/mise/config.toml`, then run `mise install`.
- **Add/remove global pnpm tools** — Edit `pnpm/globals.txt` (one package per line), then run the bootstrap or:
  ```bash
  pnpm add -g $(grep -v '^#' ~/dotfiles/pnpm/globals.txt | grep -v '^[[:space:]]*$' | paste -sd ' ')
  ```

---

## After Setup

- **mise** — In project directories you can run `mise use node@20` (etc.) to pin a runtime for that project; mise will read `.mise.toml` or `.tool-versions`.
- **Starship** — Your prompt will show the current directory, git state, and detected runtimes. Config is in `~/.config/starship.toml` (symlinked from this repo).
- **zoxide** — Use `z <dirname>` to jump to frequently used directories.

---

## Tips for Beginners

- **Dotfiles** = config files whose names usually start with `.` (e.g. `.zshrc`, `.gitconfig`). This repo keeps them in one place and **symlinks** them into `$HOME` so you edit one copy and all shells use it.
- **Brewfile** = a list of what you want installed with Homebrew. `brew bundle` reads it and installs missing formulae and casks so your Mac matches the list.
- **mise** = a single tool to install and switch versions of Node, Python, Go, Ruby, etc., so you don’t install each runtime manager separately.

If something fails during bootstrap (e.g. a Homebrew cask or a mise runtime), read the error message; the script will tell you which step failed. You can fix the config and run `./scripts/bootstrap.sh` again; it’s safe to re-run.
