local file_explorer = {}

file_explorer.plugins = {
  {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-tree').setup({
        disable_netrw = false,
        update_cwd = true,
        diagnostics = { enable = true },
        view = { signcolumn = 'auto' },
        git = {
          ignore = false,
        },
      })
      local wk = require('which-key')
      wk.register({
        ['<leader>pv'] = { '<cmd>NvimTreeFindFileToggle<cr>', 'Toggle filetree' },
        ['<leader>ff'] = { '<cmd>NvimTreeFindFile<cr>', 'Find current page position' },
      })
    end,
  },
}

return file_explorer
