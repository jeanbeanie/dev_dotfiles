-- Neovim 0.11+ LSP setup (uses vim.lsp.config instead of require("lspconfig").setup)

-- Mason installs LSP servers (like tsserver + eslint) into Neovim's data dir
require ("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls", -- Typescript/Javascript
    "eslint",
  },
})

-- Runs when an LSP server attaches to a buffer
local on_attach = function(_, bufnr)
  -- restricts these keymaps to current buffer only
  local opts = { buffer = bufnr }

  -- NAVIGATION/INFO
  -- go to definition of symbol under cursor
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  -- list references/uses where used in project
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  -- show hover docs
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  -- REFACTORING/ACTIONS
  -- rename across project
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  -- show code actions available
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  -- DIAGNOSTICS
  -- jump to prev diagnostic error/warning in current buffer
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  -- jump to next diagnostic
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end

-- Define server configs using the new API
vim.lsp.config("ts_ls", {
  on_attach = on_attach,
})

vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    -- TODO test to see if I would ever use this and remove if not: 
    -- Manual "fix all" keybinding 
    vim.keymap.set("n", "<leader>ef", "<cmd>EslintFixAll<cr>", {
      buffer = bufnr,
      desc = "ESLint: Fix all",
    })
  end,
})

-- Enable the servers so they can start automatically
vim.lsp.enable({ "ts_ls", "eslint" })
