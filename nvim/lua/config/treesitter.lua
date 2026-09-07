local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
  return
end

local ensure_installed = {
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
}

ts.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local installed_set = {}
for _, lang in ipairs(ts.get_installed and ts.get_installed() or {}) do
  installed_set[lang] = true
end

local to_install = {}
for _, lang in ipairs(ensure_installed) do
  if not installed_set[lang] then
    table.insert(to_install, lang)
  end
end

if #to_install > 0 then
  ts.install(to_install)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
