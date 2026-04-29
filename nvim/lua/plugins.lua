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
  {
    "folke/tokyonight.nvim",
    lazy = false, -- load during startup so theme is avaiable immediately
    priority = 1000, -- load earlier than other UI plugins
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
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
})
