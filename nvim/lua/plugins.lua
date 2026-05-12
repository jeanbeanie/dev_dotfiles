-- Plugin manager bootstrap + plugin list (lazy.nvim)

-- lazy.nvim dir (Neovim "data" dir, not config)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- download lazy.nvim if not currenlty installed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- add lazy.nvim to neovim's runtime path so `require("lazy")` works
vim.opt.rtp:prepend(lazypath)

-- declare plugins
require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- Telescope: fuzzy finder (files, text grep, buffers, help tags, etc.)
  {
    "nvim-telescope/telescope.nvim",
    -- Version tag; tends to be more stable than tracking latest commit
    tag = "0.1.8",
    -- Telescope requires plenary.nvim (Lua utility functions used by many plugins)
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          -- todo: config layout/ignore patterns later; keeping minimal for now
        },
      })
    end,
  },
   -- LSP installer/manager (installs language servers like tsserver)
  { "williamboman/mason.nvim", config = true },

  -- Bridges mason.nvim with lspconfig (easy setup per language server)
  { "williamboman/mason-lspconfig.nvim" },

  -- Neovim's LSP client configuration (actual LSP wiring)
  { "neovim/nvim-lspconfig" },

  -- File tree (VS Code-like explorer)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- file icons (optional but nice)
    config = function()
      require("nvim-tree").setup({
        -- Minimal sensible defaults; tweak later
        view = { width = 35 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
    end,
  },

  -- Git change indicators in the sign column (+ hunk actions)
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Buffer tabline (gives you VS Code-ish tabs for open buffers)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({})
    end,
  },
 -- Completion UI (like IntelliSense menu)
  { "hrsh7th/nvim-cmp" },

  -- LSP source for completion (so TS/ESLint suggestions show up)
  { "hrsh7th/cmp-nvim-lsp" },

  -- Snippet engine
  { "L3MON4D3/LuaSnip" },

  -- Snippet source for nvim-cmp
  { "saadparwaiz1/cmp_luasnip" },

  -- A big set of pre-made snippets (VS Code style snippets)
  { "rafamadriz/friendly-snippets" },

  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  -- Neovim sessions
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
  },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
  },
})
