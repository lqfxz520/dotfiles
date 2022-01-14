call plug#begin('~/.vim/plugged')
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
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
Plug 'sainnhe/gruvbox-material'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'nvim-lualine/lualine.nvim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

" Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua' " explorer
call plug#end()

lua vim.lsp.set_log_level('debug')
lua require('vim.lsp.log').set_format_func(vim.inspect)

let mapleader = " "
let g:tcomment#filetype#guess_vue = 0

runtime! lua/util.lua
lua require("lsp")


augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
