# dev_dotfiles

My (Jeane's) super deluxe exclusive configuration files, use them at your own risk! 😈

## What's here

| Repo path                  | Symlinked to                  | Notes |
|-----------------------------|--------------------------------|-------|
| `zsh/.zshrc`                | `~/.zshrc`                     | oh-my-zsh config, PATH exports |
| `zsh/.zshrc.pre-oh-my-zsh`  | (not linked)                   | backup saved by the oh-my-zsh installer |
| `bash/.bashrc`              | `~/.bashrc`                    | rarely used day-to-day (zsh is the login shell), kept for when bash is invoked directly |
| `tmux/.tmux.conf`           | `~/.tmux.conf`                 | |
| `nvim/init.lua`             | `~/.config/nvim/init.lua`      | entrypoint, Neovim 0.11+ (`vim.lsp.config` API) |
| `nvim/lua/`                 | `~/.config/nvim/lua`           | plugins, LSP, linting, completion, treesitter config |
| `nvim/CHEATSHEET.md`        | (not linked)                   | keymap/command cheatsheet; press `<Space>?` in nvim to open it |
| `nvim/lazy-lock.json`       | `~/.config/nvim/lazy-lock.json`| pinned plugin commits, managed by lazy.nvim |
| `nvim-old/`                 | (not linked)                   | legacy vimscript config, kept for reference only — not active |
| `omp/AGENTS.md`             | `~/.omp/agent/AGENTS.md`       | global agent preferences for omp (plan format, commit message style) |
| `omp/config.yml`            | `~/.omp/agent/config.yml`      | omp settings: model roles, bash approval patterns, theme |
| `omp/commands/`             | `~/.omp/agent/commands`        | custom omp slash commands (`/impl-review`) |

## Prerequisites

Install before symlinking, or `nvim`/`zsh` will error on first launch:

- `git`
- `zsh` + [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) — installing oh-my-zsh will overwrite `~/.zshrc` with its own default, so symlink `zsh/.zshrc` back into place *after* the oh-my-zsh installer finishes (or `chsh -s $(which zsh)` first, then follow the setup steps below in order)
- `tmux`
- Neovim **0.11+** (plugins/LSP config here use APIs that don't exist on older versions)
- `ripgrep` (`rg`) — used by Telescope's live grep
- `node` + `npm` — required by the LSP servers and linters Mason installs (`ts_ls`, `eslint`, `html`, `cssls`, `htmlhint`)

Everything else (plugin manager, LSP servers, linters, treesitter parsers) installs itself on first Neovim launch.

## Setup from scratch

1. Clone the repo:
   ```sh
   git clone git@github.com:jeanbeanie/dev_dotfiles.git ~/dev_dotfiles
   ```
2. Install oh-my-zsh if it isn't already (this generates its own default `~/.zshrc`, which the next step overwrites):
   ```sh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```
3. Symlink everything into place:
   ```sh
   ln -sf ~/dev_dotfiles/zsh/.zshrc ~/.zshrc
   ln -sf ~/dev_dotfiles/bash/.bashrc ~/.bashrc
   ln -sf ~/dev_dotfiles/tmux/.tmux.conf ~/.tmux.conf

   mkdir -p ~/.config/nvim
   ln -sf ~/dev_dotfiles/nvim/init.lua ~/.config/nvim/init.lua
   ln -sf ~/dev_dotfiles/nvim/lazy-lock.json ~/.config/nvim/lazy-lock.json
   ln -sf ~/dev_dotfiles/nvim/lua ~/.config/nvim/lua

   mkdir -p ~/.omp/agent
   ln -sf ~/dev_dotfiles/omp/AGENTS.md ~/.omp/agent/AGENTS.md
   ln -sf ~/dev_dotfiles/omp/config.yml ~/.omp/agent/config.yml
   ln -sfn ~/dev_dotfiles/omp/commands ~/.omp/agent/commands
   ```
4. Restart the shell (`exec zsh`) to pick up the new `.zshrc`.
5. Launch `nvim`. On first run it will:
   - clone `lazy.nvim` (the plugin manager) automatically
   - install all plugins listed in `nvim/lua/plugins.lua`, pinned to the commits in `lazy-lock.json`
   - install the LSP servers and linters listed in `nvim/lua/lsp.lua` via Mason (LSP servers through `mason-lspconfig`, linters like `htmlhint` through `mason-tool-installer`)
   - install the treesitter parsers listed in `nvim/lua/config/treesitter.lua`

   This can take a minute or two and may need a second `nvim` restart to fully settle.
