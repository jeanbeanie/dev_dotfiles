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
pcall(function() require("trouble").setup({}) end)

-- Colorscheme: Catppuccin (ultra-dark)
local ok, catppuccin = pcall(require, "catppuccin")
if ok then
  catppuccin.setup({
    flavour = "mocha",  -- latte, frappe, macchiato, mocha
    transparent_background = true,
  })
  vim.cmd.colorscheme("catppuccin")
end

-- Sessions (auto-save/restore per working directory)
pcall(function()
  require("persistence").setup({
    dir = vim.fn.stdpath("state") .. "/sessions/", -- where sessions live
    options = { "buffers", "curdir", "tabpages", "winsize" },
  })
end)

-- Project root detection (so sessions are per-project)
pcall(function()
  require("project_nvim").setup({
    manual_mode = false,
    detection_methods = { "pattern" },
    patterns = {
      ".git",
      -- JS/TS
      "package.json",
      "tsconfig.json",
      "jsconfig.json",
      "pnpm-workspace.yaml",
      "yarn.lock",
      "bun.lockb",
      "deno.json",
      "deno.jsonc",
      -- other common project roots
      "pyproject.toml",
      "Cargo.toml",
      "go.mod",
      "composer.json",
      "Makefile",
    },
  })
end)

-- Auto-cd to detected project root (plays well with persistence.nvim)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local ok, project = pcall(require, "project_nvim.project")
    if not ok then return end

    local root = project.get_project_root()
    if root and root ~= "" then
      vim.cmd("cd " .. vim.fn.fnameescape(root))
    end
  end,
})

-- Auto-restore session on startup (per project root)
vim.api.nvim_create_autocmd("VimEnter", {
  nested = true,
  callback = function()
    -- Don’t auto-restore if nvim was started with explicit file args
    if vim.fn.argc() > 0 then
      return
    end

    local ok, persistence = pcall(require, "persistence")
    if not ok then
      return
    end

    -- Only load if a session exists for this cwd
    persistence.load()
  end,
})

-- disable treesitter-based highlighting in telescope previews
pcall(function()
  require("telescope").setup({
    defaults = {
      preview = {
        treesitter = false,
      },
    },
  })
end)

-- group leader menus for which-key
pcall(function()
  local wk = require("which-key")
  wk.add({
    { "<leader>f", group = "Find (Telescope)" },
    { "<leader>g", group = "Git" },
    { "<leader>q", group = "Session" },
    { "<leader>x", group = "Trouble/Diagnostics" },
  })
end)

--- Completion config
require("config.cmp")
-- Language Server Protocol
require("lsp")
-- Treesitter config
require("config.treesitter")

-- Nvim Tree Toggle
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File tree: toggle" })

-- Telescope keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Grep text (ripgrep)" })
vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "List buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Help tags" })

-- Trouble keymaps (make it behave like a "Problems" panel)
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble: toggle workspace diagnostics" })
vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble: toggle document diagnostics" })
-- Optional explicit close
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble close<cr>", { desc = "Trouble: close" })


-- Persistence keymaps
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end,
  { desc = "Session: restore for cwd" })
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end,
  { desc = "Session: restore last" })
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end,
  { desc = "Session: stop saving" })

-- Git (gitsigns)
vim.keymap.set("n", "]c", function() require("gitsigns").next_hunk() end, { desc = "Git: next hunk" })
vim.keymap.set("n", "[c", function() require("gitsigns").prev_hunk() end, { desc = "Git: prev hunk" })

vim.keymap.set("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Git: preview hunk" })
vim.keymap.set("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "Git: stage hunk" })
vim.keymap.set("n", "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Git: reset hunk" })

vim.keymap.set("n", "<leader>gS", function() require("gitsigns").stage_buffer() end, { desc = "Git: stage buffer" })
vim.keymap.set("n", "<leader>gR", function() require("gitsigns").reset_buffer() end, { desc = "Git: reset buffer" })

vim.keymap.set("n", "<leader>gb", function() require("gitsigns").blame_line() end, { desc = "Git: blame line" })
vim.keymap.set("n", "<leader>gB", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Git: toggle line blame" })

