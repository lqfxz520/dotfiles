---@type Feature
local editor = {}

local function set_filetype()
  vim.cmd([[filetype on]])
  vim.cmd([[filetype plugin on]])
  vim.g.do_filetype_lua = 1
  -- vim.g.did_load_filetypes = 1
  local filetypes = {
    ['*html'] = 'html',
    ['tsconfig.json'] = 'jsonc',
  }
  local ft_group = vim.api.nvim_create_augroup('filetypes', {})
  for pattern, filetype in pairs(filetypes) do
    vim.api.nvim_create_autocmd(
      { 'BufNewFile', 'BufRead' },
      { group = ft_group, pattern = pattern, command = 'setfiletype ' .. filetype, once = true }
    )
  end
end

editor.pre = function()
  vim.cmd('syntax enable')
  vim.opt.foldmethod = 'expr'
  vim.opt.foldlevelstart = -1
  vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.opt.foldenable = true
  -- ignore file for all
  vim.cmd('set wildignore+=*/node_modules/*,*.swp,*.pyc,*/venv/*,*/target/*,.DS_Store')

  set_filetype()

  -- setup indent
  vim.cmd('filetype indent off')
  vim.opt.expandtab = true
  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.softtabstop = 4
  local fi_group = vim.api.nvim_create_augroup('fileindent', {})
  vim.api.nvim_create_autocmd('FileType', {
    group = fi_group,
    pattern = 'lua,javascript,typescript,javascriptreact,typescriptreact,html,css,scss,xml,yaml,json,vue',
    command = 'setlocal expandtab ts=2 sw=2 sts=2',
  })
  local highlight_yank = vim.api.nvim_create_augroup('highlightYank', {})
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = highlight_yank,
    pattern = '*',
    callback = function()
      require('vim.highlight').on_yank({ timeout = 40 })
    end,
  })
  local setft = vim.api.nvim_create_augroup('setft', {})
  vim.api.nvim_create_autocmd(
      { 'BufRead', 'BufNewFile' },
      {
          group = setft,
          pattern = '*',
          callback = function ()
              local buf = vim.api.nvim_win_get_buf(0)
              vim.bo[buf].filetype=vim.filetype.match({buf=buf})
          end
      }
  )
end

local plugins = {
  'tpope/vim-commentary', -- Comment
  'kshenoy/vim-signature', -- display sign for marks
  'mg979/vim-visual-multi', -- multi select and edit
  'machakann/vim-sandwich', -- surround edit
  'gpanders/editorconfig.nvim', -- .editorconfig
  'mbbill/undotree',
  {
    'heavenshell/vim-jsdoc',
    ft = { 'javascript', 'javascript.jsx', 'typescript', 'vue' },
    run = 'make install',
    config = function ()
      local wk = require('which-key')
      wk.register({
        ['w!!'] = { 'w !sudo tee %', 'Save as sudo', mode = 'c' },
        ['<leader>'] = {
          ['gs'] = { ':G<CR>', 'Open git pane' },
          ['gh'] = { ':diffget //3<CR>', 'rebase right box' },
          ['gu'] = { ':diffget //2<CR>', 'rebase left box' },
        },
        ['<leader>u'] = { ':UndotreeShow<CR>', 'checkout change record' },
        ['<leader>gc'] = { ':JsDoc<CR>', 'add jsdoc' },
      })
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim', -- indent hint
    event = 'BufRead',
    config = function()
      require('indent_blankline').setup({
        char = '¦',
        buftype_exclude = { 'help', 'nofile', 'nowrite', 'quickfix', 'terminal', 'prompt' },
        show_current_context = true,
        show_current_context_start = false,
      })
    end,
  },
  {
    'windwp/nvim-autopairs', -- autopairs
    requires = { 'hrsh7th/nvim-cmp' },
    config = function()
      local npairs = require('nvim-autopairs')
      local Rule = require('nvim-autopairs.rule')

      npairs.setup({
        check_ts = true,
        fast_wrap = {},
      })
      npairs.add_rules({
        Rule(' ', ' '):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),
        Rule('( ', ' )')
          :with_pair(function()
            return false
          end)
          :with_move(function(opts)
            return opts.prev_char:match('.%)') ~= nil
          end)
          :use_key(')'),
        Rule('{ ', ' }')
          :with_pair(function()
            return false
          end)
          :with_move(function(opts)
            return opts.prev_char:match('.%}') ~= nil
          end)
          :use_key('}'),
        Rule('[ ', ' ]')
          :with_pair(function()
            return false
          end)
          :with_move(function(opts)
            return opts.prev_char:match('.%]') ~= nil
          end)
          :use_key(']'),
      })
      -- If you want insert `(` after select function or method item
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async'
  },
  'JoosepAlviste/nvim-ts-context-commentstring',
  'andymass/vim-matchup',
  {
    'nvim-treesitter/nvim-treesitter', -- treesitter
    run = ':TSUpdate',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'andymass/vim-matchup',
      'kevinhwang91/nvim-ufo',
      'windwp/nvim-autopairs',
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = 'all',
        ignore_install = { 'phpdoc' },
        highlight = { enable = true },
        matchup = { enable = true },
        context_commentstring = { enable = true },
        indent = { enable = true },
      })
      vim.g.matchup_matchparen_offscreen = { method = 'popup', highlight = 'Normal', fullwidth = 1 }
      require('ufo').setup({
        provider_selector = function()
        return {'treesitter', 'indent'}
      end
      })
    end,
  },
  'tpope/vim-fugitive', -- git management
  {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      require('neogit').setup({
        integrations = { diffview = true },
      })
    end,
  },
}

editor.plugins = plugins
editor.post = function()
  local wk = require('which-key')
  wk.register({
    ['w!!'] = { 'w !sudo tee %', 'Save as sudo', mode = 'c' },
    ['<leader>'] = {
      ['gs'] = { ':G<CR>', 'Open git pane' },
      ['gh'] = { ':diffget //3<CR>', 'rebase right box' },
      ['gu'] = { ':diffget //2<CR>', 'rebase left box' },
    },
    ['<leader>u'] = { ':UndotreeShow<CR>', 'checkout change record' },
  })
end

return editor
