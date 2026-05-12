local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load snippet collection (a bunch of ready-to-use snippets)
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  -- Tell cmp how to expand snippets
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- Manual completion: do NOT autocomplete as I type
  completion = {
    autocomplete = false,
  },

  mapping = cmp.mapping.preset.insert({
    -- Manually open the completion menu
    ["<C-y>"] = cmp.mapping.complete(),

    -- Close the completion menu
    ["<Esc>"] = cmp.mapping.abort(),

    -- Confirm the selected completion item
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    -- Navigate items when the menu is open
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }),
})
