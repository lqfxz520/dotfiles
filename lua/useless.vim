call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp' " complete plugin
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'L3MON4D3/LuaSnip' " snippet plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'gruvbox-community/gruvbox' " theme
call plug#end()

lua require("lqf1")
let mapleader = " "
set completeopt=menu,menuone,noselect
