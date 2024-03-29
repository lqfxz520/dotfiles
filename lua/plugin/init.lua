require "plugin.telescope"
require "plugin.nvim-tree"
require "plugin.comp"
require "plugin.lualine"
require "plugin.treesitter"
require "plugin.bufferline"

vim.opt.termguicolors = true
require("nvim-autopairs").setup {
  disable_filetype = { "TelescopePrompt", "vim" },
}

require("colorizer").setup {
  ["*"] = {
    css = true,
    css_fn = true,
    mode = "background",
  },
}

