---@type Feature
local completion = {}

local plugins = {
  { 'onsails/lspkind-nvim', event = 'VimEnter' },
  { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
  { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
  { 'hrsh7th/vim-vsnip', after = 'nvim-cmp' },
  { 'rafamadriz/friendly-snippets', after = 'nvim-cmp' },
  {
    'hrsh7th/nvim-cmp',
    after = 'lspkind-nvim',
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end
      local function tab(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn['vsnip#available'](1) == 1 then
          feedkey('<Plug>(vsnip-expand-or-jump)', '')
        else
          fallback()
        end
      end
      local function s_tab(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn['vsnip#available'](1) == 1 then
          feedkey('<Plug>(vsnip-expand-or-jump)', '')
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
              vsnip = '[Vsnip]',
              nvim_lsp = '[LSP]',
              path = '[Path]',
            },
          }),
        },
        snippet = {
          expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-y>'] = cmp.mapping({
            c = cmp.mapping.confirm({
              select = true,
              behavior = cmp.ConfirmBehavior.Replace,
            }),
          }),
          ['<CR>'] = cmp.mapping({
            i = cmp.mapping.confirm({
              select = true,
              behavior = cmp.ConfirmBehavior.Replace,
            }),
            c = function(fallback)
              fallback()
            end,
          }),
          ['<Tab>'] = cmp.mapping({ i = tab }),
          ['<S-Tab>'] = cmp.mapping({ i = s_tab }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
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
        },
      })
    end,
  },
  {
    'gelguy/wilder.nvim',
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
