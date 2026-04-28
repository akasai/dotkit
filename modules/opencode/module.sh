MODULE_NAME="opencode"
MODULE_DESC="OpenCode editor settings, skills, presets, and plugins"
MODULE_TARGET="${HOME}/.config/opencode"

post_install() {
  if command -v npm >/dev/null 2>&1; then
    info "Running npm install..."
    (cd "$MODULE_TARGET" && npm install --silent 2>/dev/null) || warn "npm install failed"
  fi
}
