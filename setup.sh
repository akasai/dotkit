#!/bin/bash
set -euo pipefail

# dotkit bootstrap — install or update
# Usage: curl -fsSL <raw-url>/setup.sh | bash

REPO_URL="https://github.com/akasai/dotkit.git"
DOTKIT_DIR="${HOME}/.dotkit"
BRANCH="main"
BIN_DIR="${HOME}/.local/bin"

_blue()  { printf "\033[0;34m%s\033[0m" "$1"; }
_green() { printf "\033[0;32m%s\033[0m" "$1"; }
_yellow(){ printf "\033[0;33m%s\033[0m" "$1"; }
_red()   { printf "\033[0;31m%s\033[0m" "$1"; }

info()  { printf "  $(_blue "▸") %s\n" "$1"; }
ok()    { printf "  $(_green "✓") %s\n" "$1"; }
warn()  { printf "  $(_yellow "!") %s\n" "$1"; }
error() { printf "  $(_red "✗") %s\n" "$1" >&2; exit 1; }

command -v git >/dev/null 2>&1 || error "git is required"

if [ -d "${DOTKIT_DIR}/.git" ]; then
  info "Existing dotkit found. Updating..."
  cd "$DOTKIT_DIR"
  git fetch origin "$BRANCH" --quiet
  git reset --hard "origin/${BRANCH}" --quiet
  git clean -fd --quiet --exclude=.state
  ok "dotkit updated"
else
  if [ -d "$DOTKIT_DIR" ]; then
    BACKUP="${DOTKIT_DIR}.backup.$(date +%Y%m%d-%H%M%S)"
    warn "Existing ~/.dotkit found (not a repo). Backing up → $BACKUP"
    mv "$DOTKIT_DIR" "$BACKUP"
  fi

  info "Cloning dotkit..."
  git clone --branch "$BRANCH" "$REPO_URL" "$DOTKIT_DIR" --quiet
  ok "dotkit cloned"
fi

chmod +x "${DOTKIT_DIR}/dotkit"

mkdir -p "$BIN_DIR"
ln -sf "${DOTKIT_DIR}/dotkit" "${BIN_DIR}/dotkit"

if echo "$PATH" | grep -q "${BIN_DIR}"; then
  ok "dotkit command available"
else
  warn "Add to your shell profile:  export PATH=\"\${HOME}/.local/bin:\$PATH\""
fi

echo ""
ok "dotkit is ready!"
echo ""
echo "  Get started:"
echo "    dotkit list              see available modules"
echo "    dotkit install all       install everything"
echo "    dotkit install zsh git   install specific modules"
echo ""
