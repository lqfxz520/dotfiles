require "plugin.telescope"
require "plugin.nvim-tree"
require "plugin.comp"
require "plugin.lualine"
require "plugin.treesitter"

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

require("bufferline").setup {
  options = {
    numbers = "ordinal",
  },
}

vim.api.nvim_set_keymap(
  "n",
  "<A-1>",
  "<cmd>BufferLineGoToBuffer 1<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<A-2>",
  "<cmd>BufferLineGoToBuffer 2<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<A-3>",
  "<cmd>BufferLineGoToBuffer 3<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<A-4>",
  "<cmd>BufferLineGoToBuffer 4<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<A-5>",
  "<cmd>BufferLineGoToBuffer 5<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<A-6>",
  "<cmd>BufferLineGoToBuffer 6<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<A-7>",
  "<cmd>BufferLineGoToBuffer 7<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<A-1>",
  "<C-o><cmd>BufferLineGoToBuffer 1<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<A-2>",
  "<C-o><cmd>BufferLineGoToBuffer 2<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<A-3>",
  "<C-o><cmd>BufferLineGoToBuffer 3<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<A-4>",
  "<C-o><cmd>BufferLineGoToBuffer 4<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<A-5>",
  "<C-o><cmd>BufferLineGoToBuffer 5<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<A-6>",
  "<C-o><cmd>BufferLineGoToBuffer 6<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<A-7>",
  "<C-o><cmd>BufferLineGoToBuffer 7<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<A-7>",
  "<C-o><cmd>BufferLineGoToBuffer 7<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Left>",
  "<cmd>BufferLineMovePrev<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Right>",
  "<cmd>BufferLineMoveNext<CR>",
  { noremap = true, silent = true }
)
