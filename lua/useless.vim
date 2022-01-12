call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp' " complete plugin
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'L3MON4D3/LuaSnip' " snippet plugin

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

Plug 'gruvbox-community/gruvbox' " theme
call plug#end()

runtime! lua/util.lua
lua require("lqf1")

let mapleader = " "
set completeopt=menu,menuone,noselect

" Save & quit
noremap Q :q<CR>
noremap <A-s> :w<CR>
