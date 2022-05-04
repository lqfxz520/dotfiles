local basic = {}

basic.pre = function()
  vim.g.mapleader = ' '
  vim.g.do_filetype_lua = 1
  vim.g.did_load_filetypes = 0
  vim.opt.relativenumber = true
  vim.opt.number = true
  vim.opt.wrap = false
  vim.opt.smartcase = true
  vim.opt.swapfile = false
  vim.opt.backup = false
  vim.opt.undofile = true
  vim.opt.incsearch = true
  vim.opt.clipboard = 'unnamedplus'
  vim.opt.signcolumn = 'yes'
  vim.opt.scrolloff = 3
  vim.opt.sidescrolloff = 5
  vim.opt.colorcolumn = '80'
  vim.opt.mouse = 'nv'
  vim.opt.termguicolors = true -- true color
end

basic.plugins = {
  {
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient')
    end,
  },
  {
    'rmagatti/auto-session',
    config = function()
      local wk = require('which-key')
      vim.opt.sessionoptions = 'curdir,folds,help,tabpages,terminal,winsize'
      require('auto-session').setup({
        pre_save_cmds = { 'NvimTreeClose' },
        auto_session_suppress_dirs = { '~' },
      })
      wk.register({
        ['<leader>s'] = {
          r = { '<cmd>RestoreSession<cr>', 'Restore session' },
          s = { '<cmd>SaveSession<cr>', 'Save session' },
        },
      })
    end,
  },
}

basic.post = function()
  local wk = require('which-key')
  local termcode = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  wk.register({
    ['[<space>'] = { ':<C-U>put! =repeat(nr2char(10), v:count1)<CR>`[', 'Add space line before' },
    [']<space>'] = { ':<C-U>put =repeat(nr2char(10), v:count1)<CR>', 'Add space line after' },
    ['Q'] = { ':q<CR>', 'Exit current buffer' },
    ['<A-s>'] = { ':w<CR>', 'Save file' },
    ['<C-K>'] = { termcode([[<C-\><C-N>]]), 'To normal mode in terminal', mode = 't' },
    ['<leader>'] = {
      ['h'] = { '<C-W>h', 'Navigator window left' },
      ['j'] = { '<C-W>j', 'Navigator window top' },
      ['k'] = { '<C-W>k', 'Navigator window bottom' },
      ['l'] = { '<C-W>l', 'Navigator window right' },
      ['~'] = { ':terminal<CR>', 'Open terminal in current window' },
      ['Y'] = { 'gg"+yG', 'Copy content of file' },
      ['d'] = { '"_d', 'Delete content', mode = 'v' },
    },
  })
end

return basic
