local file_explorer = {
  plugins = {},
}

-- file_explorer.plugins[#file_explorer.plugins + 1] = {
--   'kyazdani42/nvim-tree.lua',
--   requires = 'kyazdani42/nvim-web-devicons',
--   config = function()
--     require('nvim-tree').setup({
--       disable_netrw = false,
--       update_cwd = true,
--       diagnostics = { enable = true },
--       view = { signcolumn = 'auto' },
--       git = {
--         ignore = false,
--       },
--     })
--     local wk = require('which-key')
--     wk.register({
--       ['<leader>pv'] = { '<cmd>NvimTreeFindFileToggle<cr>', 'Toggle filetree' },
--       ['<leader>ff'] = { '<cmd>NvimTreeFindFile<cr>', 'Find current page position' },
--     })
--   end,
-- }

file_explorer.plugins[#file_explorer.plugins + 1] = {
  'nvim-neo-tree/neo-tree.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup({
      close_if_last_window = true,
      source_selector = {
        winbar = true,
        statusline = false,
      },
      window = {
        mappings = {
          ['<tab>'] = function(state)
            local node = state.tree:get_node()
            if require('neo-tree.utils').is_expandable(node) then
              state.commands['toggle_node'](state)
            else
              state.commands['open'](state)
              vim.cmd('Neotree reveal')
            end
          end,
        },
      },
      filesystem = {
        window = {
          mappings = {
            ['o'] = 'system_open',
          },
        },
        commands = {
          system_open = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            -- open file in default application in the background
            local f = io.popen('wslpath -w ~')
            print(f:read("*a"))
            -- vim.api.nvim_command('!/mnt/c/WINDOWS/explorer.exe | wslpath -w' .. path)
          end,
        },
      },
    })
    local wk = require('which-key')
    wk.register({
      ['<leader>pv'] = {
        '<cmd>Neotree position=right action=focus reveal=true source=filesystem toggle=true<cr>',
        'Toggle filetree',
      },
      ['<leader>ff'] = {
        '<cmd>Neotree source=filesystem position=float reveal=true<cr>',
        'Find current page position',
      },
    })
  end,
}

return file_explorer
