call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp' " complete plugin
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'L3MON4D3/LuaSnip' " snippet plugin

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug('tami5/sqlite.lua') " for telescope-frecency
Plug('nvim-telescope/telescope-frecency.nvim')

Plug 'jose-elias-alvarez/nvim-lsp-ts-utils' " let tsserver be good

Plug 'gruvbox-community/gruvbox' " theme
call plug#end()

runtime! lua/util.lua
lua require("lsp")

let mapleader = " "
set completeopt=menu,menuone,noselect

" Save & quit
noremap Q :q<CR>
noremap <A-s> :w<CR>
