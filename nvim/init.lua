-- JEANE'S 2026 MINIMAL NEOVIM CONFIG FILE (Windows Friendly)
--
--
----------------------------
---- BASIC INPUT/DISPLAY ---
----------------------------

-- Set the <Leader> key (used as a prefix for custom shortcuts)
vim.g.mapleader = " "

-- Enable mouse support in all modes
--vim.opt.mouse = "a"

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable 24-bit RBG colords in the terminal
vim.opt.termguicolors = true

----------------------------
---- GUTTER/LINE# CONFIG ---
----------------------------

-- Show absolute line number in left gutter
vim.opt.number = true

-- Show relative line numbers 
--vim.opt.relativenumber = true

-- Always show the sign column (prevent text shifting is sign appears)
vim.opt.signcolumn = "yes"

----------------------------
---- TAB/SPACING CONFIG ----
----------------------------

-- Insert spaces instead of tab char when hitting TAB
vim.opt.expandtab = true

-- Number of spaces for each indent
vim.opt.shiftwidth = 2

-- Number of space a TAB counts for when editing
vim.opt.tabstop = 2

-- Smarter autoindent
vim.opt.smartindent = true


----------------------------
---- SEARCH/FIND CONFIG ----
----------------------------

-- Lower case searches are case-INsensitive
vim.opt.ignorecase = true

-- Including uppercase turns search case-sensitive
vim.opt.smartcase = true

-- Show matches while search pattern is being typed
vim.opt.incsearch = true

----------------------------
---- MISCELLANEOUS CONFIG --
----------------------------

-- Disable wrap long links
vim.opt.wrap = false

-- Load plugin setup in /lua/plugins.lua
require("plugins")
