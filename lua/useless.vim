call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
call plug#end()

lua require("lqf1")
let mapleader = " "
set completeopt=menu,menuone,noselect
