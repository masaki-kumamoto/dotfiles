#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

log() {
  printf "\n==> %s\n" "$1"
}

warn() {
  printf "\n[warn] %s\n" "$1"
}

have() {
  command -v "$1" >/dev/null 2>&1
}

backup_if_exists() {
  local target="$1"

  if [ -e "$target" ] || [ -L "$target" ]; then
    local backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
    warn "Backing up ${target} -> ${backup}"
    mv "$target" "$backup"
  fi
}

link_file() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    log "Already linked: $target"
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    backup_if_exists "$target"
  fi

  ln -s "$source" "$target"
  log "Linked $target -> $source"
}

install_brew_bundle() {
  if ! have brew; then
    warn "Homebrew not found. Install it first, then re-run this script."
    return
  fi

  if [ -f "${DOTFILES_DIR}/Brewfile" ]; then
    log "Installing packages from Brewfile"
    brew bundle --file="${DOTFILES_DIR}/Brewfile"
  else
    warn "No Brewfile found"
  fi
}

link_dotfiles() {
  log "Linking dotfiles"

  link_file "${DOTFILES_DIR}/git/.gitconfig" "${HOME}/.gitconfig"
  link_file "${DOTFILES_DIR}/zsh/.zshrc" "${HOME}/.zshrc"
  link_file "${DOTFILES_DIR}/starship/.config/starship.toml" "${HOME}/.config/starship.toml"
  link_file "${DOTFILES_DIR}/mise/.config/mise/config.toml" "${HOME}/.config/mise/config.toml"
}

install_mise_tools() {
  if ! have mise; then
    warn "mise not found. Skipping runtime installation."
    return
  fi

  if [ -f "${DOTFILES_DIR}/mise/.config/mise/config.toml" ]; then
    log "Installing runtimes from mise config"
    mise install
  else
    warn "No mise config found"
  fi
}

install_pnpm_globals() {
  if ! have pnpm; then
    warn "pnpm not found. Skipping global pnpm packages."
    return
  fi

  local list="${DOTFILES_DIR}/pnpm/globals.txt"
  if [ -f "$list" ]; then
    log "Installing global pnpm packages from pnpm/globals.txt"
    local pkgs
    pkgs=$(grep -v '^#' "$list" | grep -v '^[[:space:]]*$' | paste -sd ' ')
    if [ -n "$pkgs" ]; then
      pnpm add -g $pkgs
    fi
  else
    warn "No pnpm/globals.txt found"
  fi
}

post_checks() {
  log "Post-install checks"

  have brew && brew --version | head -n 1
  have mise && mise --version
  have starship && starship --version
  have git && git --version
}

main() {
  log "Starting bootstrap"

  install_brew_bundle
  link_dotfiles
  install_mise_tools
  install_pnpm_globals
  post_checks

  log "Bootstrap complete"
  printf "\nRestart your shell with: exec zsh\n"
}

main "$@"