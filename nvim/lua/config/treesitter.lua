local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

configs.setup({
  ensure_installed = {
    -- Neovim config
    "lua",
    "vim",
    "vimdoc",

    -- JS/TS
    "javascript",
    "typescript",
    "tsx",

    -- misc web stuff
    "json",
    "html",
    "css",

    -- configs/scripts
    "yaml",
    "markdown",
    "markdown_inline",
    "bash",
  },

  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },
})
