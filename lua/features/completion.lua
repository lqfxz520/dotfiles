---@type Feature
local completion = {}

local plugins = {
  { 'onsails/lspkind-nvim' },
  {
    'hrsh7th/nvim-cmp',
    requires = {
      'onsails/lspkind-nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      -- snippets
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    want = 'rafamadriz/friendly-snippets',
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local luasnip = require('luasnip')
      -- require('luasnip.loaders.from_vscode').lazy_load()
      local function tab(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end
      local function s_tab(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end

      cmp.setup({
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        experimental = {
          ghost_text = true,
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            menu = {
              buffer = '[Buffer]',
              luasnip = '[LuaSnip]',
              nvim_lsp = '[LSP]',
              path = '[Path]',
            },
          }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-y>'] = cmp.mapping({
            c = cmp.mapping.confirm({ select = true }),
          }),
          ['<CR>'] = cmp.mapping({
            i = cmp.mapping.confirm({ select = true }),
            c = function(fallback)
              fallback()
            end,
          }),
          ['<Tab>'] = cmp.mapping({ i = tab }),
          ['<S-Tab>'] = cmp.mapping({ i = s_tab }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          {
            name = 'buffer',
            option = {
              -- Visible buffers
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
        }),
      })
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    config = function()
      require('control.lsp').add_caps_setter(require('cmp_nvim_lsp').update_capabilities)
    end,
  },
  {
    'gelguy/wilder.nvim',
    opt = false,
    config = function()
      local wilder = require('wilder')
      wilder.setup({
        modes = { ':', '/', '?' },
      })
      wilder.set_option('pipeline', {
        wilder.branch(
          wilder.cmdline_pipeline({
            language = 'python',
            fuzzy = 1,
          }),
          wilder.python_search_pipeline({
            pattern = wilder.python_fuzzy_pattern(),
            sorter = wilder.python_difflib_sorter(),
            engine = 're',
          })
        ),
      })
      wilder.set_option(
        'renderer',
        wilder.popupmenu_renderer({
          highlighter = wilder.basic_highlighter(),
          pumlend = 20,
          max_height = 15,
        })
      )
    end,
  },
}
completion.plugins = plugins

return completion
