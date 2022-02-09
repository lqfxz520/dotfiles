call plug#begin('~/.vim/plugged')
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' " Snippets plugin
Plug 'rafamadriz/friendly-snippets'
Plug 'onsails/lspkind-nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'JoosepAlviste/nvim-ts-context-commentstring', {'branch': 'main'}
Plug 'windwp/nvim-ts-autotag', {'branch': 'main'}
Plug 'andymass/vim-matchup'
Plug 'windwp/nvim-autopairs'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'tami5/sqlite.lua' " for telescope-frecency
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'nvim-telescope/telescope-cheat.nvim'

Plug 'jose-elias-alvarez/nvim-lsp-ts-utils' " let tsserver be good

Plug 'gruvbox-community/gruvbox' " theme
Plug 'sainnhe/gruvbox-material'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua' " explorer

Plug 'norcalli/nvim-colorizer.lua'
Plug 'gpanders/editorconfig.nvim'
call plug#end()

" lua vim.lsp.set_log_level('debug')
" lua require('vim.lsp.log').set_format_func(vim.inspect)

let mapleader = " "
let g:tcomment#filetype#guess_vue = 0
let g:matchup_matchparen_offscreen
      \ = {'method': 'popup', 'highlight': 'Normal', 'fullwidth': 1}

runtime! lua/util.lua
lua require("lsp")
lua require("plugin")


augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END
