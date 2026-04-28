# dotkit

Personal dotfiles package manager. Install only what you need, keep every machine in sync.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/akasai/dotkit/main/setup.sh | bash
```

Or clone manually:

```bash
git clone git@github.com:akasai/dotkit.git ~/.dotkit
~/.dotkit/dotkit install all
```

## Usage

```bash
dotkit install zsh opencode    # install specific modules
dotkit install all             # install everything
dotkit update                  # pull latest + re-link
dotkit list                    # show modules and status
dotkit status                  # symlink health check
dotkit uninstall <module>      # remove + restore originals
```

## Modules

| Module | Target | Contents |
|--------|--------|----------|
| `zsh` | `~/` | `.zshrc` |
| `opencode` | `~/.config/opencode/` | oh-my-openagent, plugins, skills, presets |
| `claude` | `~/.claude/` | `CLAUDE.md`, skills |
| `git` | `~/` | `.gitconfig` |

## How It Works

Each module lives in `modules/<name>/` with a `module.sh` (metadata + hooks) and a `files/` directory. `dotkit install` creates symlinks from `files/` into the target location.

- Existing files are backed up as `.dotkit-backup`
- `dotkit uninstall` removes symlinks and restores backups
- `dotkit update` pulls the repo and re-links all installed modules
- Changes to linked files go directly into this repo

## Adding a Module

```bash
mkdir -p modules/mymodule/files
```

Create `modules/mymodule/module.sh`:

```bash
MODULE_NAME="mymodule"
MODULE_DESC="Short description"
MODULE_TARGET="${HOME}/.config/mymodule"
```

Place files in `modules/mymodule/files/` and run `dotkit install mymodule`.

## Requirements

- git
- bash 3.2+ (macOS default works)
- npm (for opencode module only)
