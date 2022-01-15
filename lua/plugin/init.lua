require "plugin.telescope"
require "plugin.nvim-tree"
require "plugin.comp"
require "plugin.lualine"
require "plugin.treesitter"

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
