-- luasnip setup
local luasnip = require "luasnip"
local cmp = require "cmp"
local lspkind = require "lspkind"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match "%s"
      == nil
end

require("luasnip.loaders.from_vscode").lazy_load()
---@diagnostic disable-next-line: redundant-parameter
cmp.setup {
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        buffer = "[Buffer]",
        path = "[Path]",
      },
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),

    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-x><C-i>"] = cmp.mapping.complete(),
    -- ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
}

-- cmp.setup.cmdline(':', {
--     sources = {
--         { name = 'path' }
--     }
-- })

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})
