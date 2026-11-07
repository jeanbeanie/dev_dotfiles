local lint = require("lint")

-- Which linters run for which filetypes (binaries are installed in lsp.lua via mason-tool-installer)
lint.linters_by_ft = {
  html = { "htmlhint" },
}

-- Lint when a file is opened, after saving, and after leaving insert mode
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})
