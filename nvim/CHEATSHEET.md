# Neovim Cheatsheet

Leader = `<Space>`. Pause after pressing it and which-key shows the available follow-ups.
Open this file in nvim with `<leader>?`.

**★ = custom mapping from this config.** Everything else is built into Vim/Neovim or a plugin's default.

---

## 1. Highlighting & selection

| Keys | What it does |
|---|---|
| `v` / `V` / `Ctrl-v` | Visual: characters / lines / block |
| `gv` | Reselect the last visual selection |
| `o` (in visual) | Jump to the other end of the selection |
| `viw` / `vaw` | Select inner word / word + space |
| `vi(` `vi{` `vi[` `vi"` `vi'` | Select inside brackets/quotes (`a` instead of `i` includes the delimiters) |
| `vit` / `vat` | Select inside / around an HTML tag |
| `vip` / `vap` | Select paragraph |
| `ggVG` | Select the whole file |
| `y` `d` `c` `>` `<` `=` | Act on the selection (yank, delete, change, indent, outdent, auto-indent) |
| `/text` + `Enter` | Search forward, matches highlight as you type (incsearch) |
| `n` / `N` | Next / previous match |
| `*` / `#` | Search word under cursor forward / backward |
| `:noh` | Clear search highlighting |
| `:%s/old/new/gc` | Replace in file, confirm each |
| `:s/old/new/g` | Replace on the current line (or the visual selection) |

Search is case-insensitive until you type a capital (`ignorecase` + `smartcase`).
Yank/paste uses the system clipboard (via win32yank on WSL).

---

## 2. Syntax highlighting (Treesitter)

| Command / keys | What it does |
|---|---|
| `:Inspect` | Show highlight groups and treesitter nodes under the cursor |
| `:InspectTree` | Live syntax tree of the buffer |
| `:TSInstall <lang>` | Install a parser |
| `:TSUpdate` | Update all parsers |
| `:set filetype=<ft>` | Force a filetype if highlighting is wrong |
| `:syntax on` / `:syntax off` | Toggle legacy syntax (treesitter is separate) |
| `:hi` | List all highlight groups |
| `:hi Comment` | Show one group's colors |
| `za` / `zc` / `zo` | Toggle / close / open fold under cursor |
| `zR` / `zM` | Open / close all folds |

Parsers auto-installed: lua, vim, vimdoc, javascript, typescript, tsx, json, html, css, yaml, markdown, markdown_inline, bash.
Folds use treesitter (`foldexpr`) when a parser exists for the filetype.
Colorscheme: Catppuccin mocha, transparent background.

---

## 3. Go to definition & LSP

Active for TypeScript/JavaScript (`ts_ls`, `eslint`), HTML (`html`) and CSS (`cssls`). HTML also gets linting from HTMLHint via nvim-lint (`lua/config/lint.lua`): unclosed or mismatched tags, missing doctype, duplicate ids, uppercase tags/attrs. Missing `alt` is NOT on by default: add `{"alt-require": true}` to a `.htmlhintrc` in the project. It runs on open, save and leaving insert mode, and shows up as normal diagnostics (`[d`/`]d`, Trouble). These maps exist only in buffers where a server is attached.

| Keys | What it does |
|---|---|
| `gd` ★ | Go to definition |
| `gr` ★ | List references |
| `K` ★ | Hover docs |
| `<leader>rn` ★ | Rename symbol across the project |
| `<leader>ca` ★ | Code actions (quick fixes, imports, refactors) |
| `[d` / `]d` ★ | Previous / next diagnostic |
| `Ctrl-o` / `Ctrl-i` | Jump back / forward through the jump list |
| `Ctrl-]` / `Ctrl-t` | Tag jump / pop back (uses LSP when attached) |
| `gO` | Document symbols outline (Neovim 0.11 default) |
| `:checkhealth vim.lsp` | LSP status and attached servers |
| `:LspInfo` / `:LspLog` | Server info / log |
| `:Mason` | Install or update language servers and linters |

Note: your buffer-local `gr` shadows Neovim 0.11's `grn` / `gra` / `grr` / `gri`, so those need `gr` to time out first.

---

## 4. Autocorrect, spelling & fixes

Spell checking is **off by default**.

| Keys / command | What it does |
|---|---|
| `:set spell` / `:set nospell` | Toggle spell check |
| `:set spelllang=en_us` | Choose language |
| `]s` / `[s` | Next / previous misspelled word |
| `z=` | Suggestions for the word under cursor |
| `1z=` | Accept the first suggestion immediately |
| `zg` / `zw` | Add word to / mark word as wrong in your dictionary |
| `zug` | Undo `zg` |
| `Ctrl-x s` (insert) | Spelling suggestions while typing |
| `<leader>ef` ★ | ESLint: fix all auto-fixable problems (eslint buffers) |
| `<leader>ca` ★ | Code actions, including per-error quick fixes |
| `[d` / `]d` ★ | Walk through diagnostics |
| `Ctrl-w d` | Show diagnostic under cursor in a float |
| `<leader>xx` ★ | Trouble: workspace diagnostics panel |
| `<leader>xd` ★ | Trouble: current-buffer diagnostics |
| `<leader>xq` ★ | Close Trouble |
| `:%s/teh/the/g` | Manual find-and-fix |
| `:iabbrev teh the` | Session-only autocorrect while typing |
| `u` / `Ctrl-r` | Undo / redo |

---

## 5. Completion & snippets

Autocomplete is **manual**: nothing pops up until you ask. Sources: LSP and LuaSnip (friendly-snippets).

| Keys (insert mode) | What it does |
|---|---|
| `Ctrl-y` ★ | Open the completion menu |
| `Ctrl-n` / `Ctrl-p` ★ | Next / previous item |
| `Enter` ★ | Confirm selected item (selects the first if none highlighted) |
| `Esc` ★ | Close the menu |
| `Ctrl-x Ctrl-f` | Built-in file path completion |
| `Ctrl-x Ctrl-n` | Built-in word completion from the buffer |

Autopairs inserts the closing `)` `]` `}` `"` `'` automatically.

---

## 6. Commenting (Comment.nvim)

| Keys | What it does |
|---|---|
| `gcc` | Toggle line comment |
| `gc{motion}` | Comment a motion (`gcap` paragraph, `gc3j` three lines down) |
| `gc` (visual) | Comment the selection |
| `gbc` | Toggle block comment |
| `gb{motion}` / `gb` (visual) | Block-comment a motion / selection |

---

## 7. Files, search & buffers

| Keys / command | What it does |
|---|---|
| `<leader>e` ★ | Toggle file tree (nvim-tree) |
| `<leader>ff` ★ | Telescope: find files |
| `<leader>fg` ★ | Telescope: live grep (ripgrep) |
| `<leader>fb` ★ | Telescope: open buffers |
| `<leader>fh` ★ | Telescope: help tags |
| `:bn` / `:bp` | Next / previous buffer (shown in bufferline) |
| `:bd` | Close buffer |
| `Ctrl-^` | Toggle between the last two buffers |
| `Ctrl-w v` / `Ctrl-w s` | Split vertical / horizontal |
| `Ctrl-w h/j/k/l` | Move between splits |
| `Ctrl-w c` / `Ctrl-w o` | Close split / keep only this one |

Inside Telescope: `Ctrl-n`/`Ctrl-p` move, `Enter` opens, `Esc` closes.
Inside nvim-tree: `a` new, `d` delete, `r` rename, `Enter` open, `g?` full help.

---

## 8. Git (gitsigns)

| Keys | What it does |
|---|---|
| `]c` / `[c` ★ | Next / previous hunk |
| `<leader>gp` ★ | Preview hunk |
| `<leader>gs` ★ | Stage hunk |
| `<leader>gr` ★ | Reset hunk |
| `<leader>gS` ★ | Stage whole buffer |
| `<leader>gR` ★ | Reset whole buffer |
| `<leader>gb` ★ | Blame line |
| `<leader>gB` ★ | Toggle inline blame |

---

## 9. Sessions & projects

| Keys | What it does |
|---|---|
| `<leader>qs` ★ | Restore session for current directory |
| `<leader>ql` ★ | Restore the last session |
| `<leader>qd` ★ | Stop saving the session |

On startup (with no file arguments) nvim `cd`s to the detected project root (`.git`, `package.json`, `tsconfig.json`, etc.) and auto-restores that project's session.
Project switching between projects is provided by `project-switcher.nvim`.

---

## 10. Quick tips

- Press `<Space>` and wait: which-key lists every leader mapping.
- `:Lazy` plugin manager UI (`:Lazy sync` to update, then commit `lazy-lock.json`).
- `:Telescope keymaps` fuzzy-search every mapping.
- `:help <topic>` or `<leader>fh` to search help.
- `.` repeats the last change; `q{a-z}` records a macro, `@{a-z}` plays it.
- `:e!` reload the file from disk; `:w !sudo tee %` write a root-owned file.
