# Dotfiles

This repository is a personal macOS setup for ARM64-based Macs with Apple Silicon, including M-series models such as M1, M2, M3, M4, and M5.

The repo is designed around native Apple Silicon tooling: a native `arm64` shell, Homebrew installed at `/opt/homebrew`, and package/runtime installs that resolve to Apple Silicon builds instead of Intel/Rosetta ones.

It installs apps, developer tools, programming runtimes, shell settings, and Git defaults in one repeatable setup. Instead of setting up everything by hand every time, you can run the bootstrap script and quickly get the same working environment again.

This is useful for Mac users because a fresh macOS install usually does not include the tools needed for development. Homebrew installs the apps and command-line tools, `mise` installs programming languages and runtimes, and the linked config files make your terminal and Git settings stay consistent across machines.

## What This Repo Manages

- Shell config through `zsh/.zshrc`
- Prompt config through `starship/.config/starship.toml`
- Runtime versions through `mise/.config/mise/config.toml`
- Git defaults through `git/.gitconfig`
- Global pnpm CLI packages through `pnpm/globals.txt`
- Brew-installed CLI tools and desktop apps through `Brewfile`
- End-to-end setup through `scripts/bootstrap.sh`

## Current Tooling

This repo currently installs and configures:

- Core CLI tools: `git`, `gh`, `jq`, `ripgrep`, `fd`, `bat`, `tree`, `htop`, `coreutils`, `gnu-sed`, `stow`
- Shell workflow tools: `mise`, `starship`, `zoxide`, `fzf`, `direnv`, `eza`, `lazygit`, `tmux`, `neovim`, `podman`
- Cloud tooling: `awscli`, `azure-cli`, `gcloud-cli`, `snowflake-cli`
- Language tooling: `php`, `composer`
- Runtime versions via `mise`: Node LTS, pnpm, Bun, Python 3.12, uv, Go, Rust, Java 21, .NET 8, Ruby, Terraform, `jq`, and `yq`
- Global pnpm CLIs: Claude Code, Claude, Claude Cowork, Gemini CLI, and Codex
- macOS apps from Homebrew casks: Arc, Raycast, Rectangle, AltTab, Stats, Windows App, ChatGPT, Cursor, Cursor CLI, VS Code, iTerm2, OrbStack, Postman, Codex, Claude, Claude Code, Grammarly, DeepL, Obsidian, Descript, The Unarchiver, VLC, and Elgato Camera Hub

The exact package list lives in `Brewfile`, so update that file rather than this README when your app/tool inventory changes.

## Prerequisites

- macOS on Apple Silicon (`arm64`)
- A native Apple Silicon shell session (`uname -m` should print `arm64`)
- Homebrew installed at `/opt/homebrew` and available on `PATH`

If Homebrew is not installed yet:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installation, follow Homebrew's printed shell setup steps before running the bootstrap script.

If `uname -m` prints `x86_64`, your terminal is running under Rosetta. Switch to a native Apple Silicon terminal session before using this repo.

## Quick Start

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./scripts/bootstrap.sh
exec zsh
```

Before running the bootstrap on a new machine, review `git/.gitconfig` and replace the user name and email with your own if needed.

## What `bootstrap.sh` Does

`scripts/bootstrap.sh` runs these steps in order:

1. Verify that macOS, the current shell, and Homebrew are all running in native Apple Silicon mode
2. `brew bundle --file=.../Brewfile`
3. Symlink the tracked config files into `$HOME`
4. Run `mise install`
5. Install global pnpm packages if `pnpm` is already available in the current shell
6. Print a few version checks

When a target file already exists, the script moves it aside to a timestamped backup like `~/.zshrc.bak.20260306120000` before creating the symlink.

## Symlinks Created

- `git/.gitconfig` -> `~/.gitconfig`
- `zsh/.zshrc` -> `~/.zshrc`
- `starship/.config/starship.toml` -> `~/.config/starship.toml`
- `mise/.config/mise/config.toml` -> `~/.config/mise/config.toml`

## First-Run Caveat

The bootstrap script installs `pnpm` through `mise`, but it only installs packages from `pnpm/globals.txt` when `pnpm` is already resolvable in the current shell.

On a brand new machine, the usual sequence is:

```bash
./scripts/bootstrap.sh
exec zsh
./scripts/bootstrap.sh
```

The second run is what reliably installs the global pnpm CLIs after `mise` activation is available in the shell.

If you prefer to do that step manually:

```bash
pnpm add -g $(grep -v '^#' ~/dotfiles/pnpm/globals.txt | grep -v '^[[:space:]]*$' | paste -sd ' ')
```

## Repo Layout

```text
dotfiles/
|-- Brewfile
|-- README.md
|-- git/.gitconfig
|-- mise/.config/mise/config.toml
|-- pnpm/globals.txt
|-- scripts/bootstrap.sh
|-- starship/.config/starship.toml
`-- zsh/.zshrc
```

## Customization

- Edit `Brewfile` and rerun `brew bundle --file=~/dotfiles/Brewfile` when you want different packages or casks.
- Edit `mise/.config/mise/config.toml` and rerun `mise install` when you want different runtime versions.
- Edit `pnpm/globals.txt` and rerun the bootstrap or `pnpm add -g ...` when you want different global CLIs.
- Put machine-specific shell overrides in `~/.zshrc.local`; `zsh/.zshrc` sources it if present.
- Keep Homebrew and shell overrides Apple Silicon-native; this repo intentionally does not support `/usr/local` Intel Homebrew.

## Notes

- `zsh/.zshrc` assumes native Apple Silicon Homebrew from `/opt/homebrew`.
- `zsh/.zshrc` enables Starship, `mise`, `zoxide`, and `fzf` when those commands are installed.
- `cd` is aliased to `z` when `zoxide` is available.
- `ls`, `ll`, `la`, and `lt` switch to `eza` automatically when installed.
- `git/.gitconfig` currently contains a real identity, so do not reuse it unchanged in another environment.

## Tooling Summary

### Config Files

These are the files the bootstrap script symlinks into `$HOME` to define shell, prompt, and Git behavior.

Source: `zsh/.zshrc`, `starship/.config/starship.toml`, `git/.gitconfig`


| Area         | Tooling set up by this repo                                                                                                             | Description                                                                                          |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| Shell config | Zsh history/completion defaults, aliases, Homebrew path setup, Starship init, `mise` activation, `zoxide` init, `fzf` shell integration | Defines the interactive shell environment and quality-of-life defaults for daily terminal use.       |
| Prompt       | `starship` with directory, git, runtime, command-duration, and prompt-character modules                                                 | Controls what appears in the prompt so language versions, Git state, and command timing are visible. |
| Git          | Git user identity, default branch, push/pull defaults, editor, and color settings                                                       | Sets the base Git identity and behavior used across repositories on the machine.                     |


### Homebrew Formulae

These are command-line packages installed through Homebrew from `Brewfile`.

Source: `Brewfile`


| Area                    | Tooling installed                                                                         | Description                                                                                         |
| ----------------------- | ----------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| Core CLI tools          | `git`, `gh`, `jq`, `ripgrep`, `fd`, `bat`, `tree`, `htop`, `coreutils`, `gnu-sed`, `stow` | Provides the baseline Unix and developer command-line utilities used across the rest of the setup.  |
| Shell workflow tools    | `mise`, `starship`, `zoxide`, `fzf`, `direnv`, `eza`, `lazygit`, `tmux`, `neovim`, `podman` | Adds the main terminal workflow tools for runtime management, navigation, search, Git, editing, and daemonless containers. |
| Cloud and platform CLIs | `awscli`, `azure-cli`, `snowflake-cli`                                                     | Installs vendor CLIs for AWS, Azure, and Snowflake from the terminal.                                |
| Language tooling        | `php`, `composer`                                                                         | Installs PHP itself and Composer for PHP dependency management outside of `mise`.                   |


### Homebrew Casks

These are installed through Homebrew casks from `Brewfile` (mostly desktop apps; some casks ship CLIs such as SDKs or agents).

Source: `Brewfile`


| Area                    | Apps installed                                                                                         | Description                                                                                                    |
| ----------------------- | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------- |
| Cloud and platform apps | `gcloud-cli`                                                                                           | Adds the Google Cloud SDK as a cask-installed application package.                                             |
| Browser                 | `arc`                                                                                                  | Installs the primary browser included in this workstation setup.                                               |
| Productivity            | `raycast`, `rectangle`, `alt-tab`, `stats`, `windows-app`                                                | Adds launchers, window management, app switching, system monitoring, and Microsoft Windows App for remote Windows sessions. |
| AI and development      | `chatgpt`, `cursor`, `cursor-cli`, `visual-studio-code`, `iterm2`, `orbstack`, `postman`, `codex-app`, `claude`, `claude-code` | Installs the main desktop tools for coding, terminal work, containers, API testing, AI-assisted workflows, and the Cursor CLI agent. |
| Writing and notes       | `grammarly-desktop`, `deepl`, `obsidian`, `descript`                                                   | Covers writing assistance, translation, note-taking, and transcription/editing workflows.                      |
| Utilities               | `the-unarchiver`, `vlc`, `elgato-camera-hub`                                                          | Adds general-purpose desktop tools for archive extraction, media playback, and Elgato webcam controls.         |


### Mise Toolchains

These are language runtimes and versioned tools installed through `mise`.

Source: `mise/.config/mise/config.toml`


| Area                 | Runtime/tool versions installed         | Description                                                                            |
| -------------------- | --------------------------------------- | -------------------------------------------------------------------------------------- |
| JavaScript ecosystem | `node@lts`, `pnpm@latest`, `bun@latest` | Provides the default JavaScript runtime and package-manager toolchain.                 |
| Python ecosystem     | `python@3.12`, `uv@latest`              | Provides Python plus a modern package and environment workflow tool.                   |
| Compiled languages   | `go@latest`, `rust@stable`              | Installs compiled-language toolchains commonly used for backend and systems work.      |
| JVM ecosystem        | `java@temurin-21`                       | Installs the Java 21 runtime and toolchain through the Temurin distribution.           |
| .NET                 | `dotnet@8`                              | Installs the .NET 8 SDK for building and running .NET applications.                    |
| Ruby                 | `ruby@latest`                           | Installs Ruby for scripts or projects that depend on the Ruby ecosystem.               |
| Infrastructure       | `terraform@latest`                      | Installs Terraform for infrastructure-as-code workflows.                               |
| Utilities            | `jq@latest`, `yq@latest`                | Installs version-managed JSON and YAML CLI processors alongside the language runtimes. |


### Global pnpm Packages

These are globally installed Node-based CLI tools installed from `pnpm/globals.txt`.

Source: `pnpm/globals.txt`


| Area    | Packages installed                                                                                                        | Description                                                                          |
| ------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| AI CLIs | `@anthropic-ai/claude-code`, `@anthropic-ai/claude`, `@anthropic-ai/claude-cowork`, `@google/gemini-cli`, `@openai/codex` | Adds globally available AI assistant CLIs for coding and general terminal workflows. |
