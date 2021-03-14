call plug#begin('~/.vim/plugged')

" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'



Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
" Plug 'nvim-treesitter/completion-treesitter'

" snippet
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" prettier
Plug 'sbdchd/neoformat'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'tweekmonster/gofmt.vim'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'vuciv/vim-bujo'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'
Plug 'skywind3000/vim-terminal-help'
Plug 'Yggdroot/indentLine'

Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline-themes'
Plug 'hardcoreplayers/oceanic-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'ryanoasis/vim-devicons'


call plug#end()


lua require("lqf")

" let g:coc_global_extensions=[
"     \ 'coc-json',
"     \ 'coc-tsserver',
"     \ 'coc-vetur',
"     \ 'coc-prettier',
"     \ 'coc-html',
"     \ 'coc-emmet',
"     \ 'coc-explorer',
"     \ 'coc-translator',
"     \ 'coc-highlight',
"     \ 'coc-tabnine'
"  \ ]

let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 0

if executable('rg')
    let g:rg_derive_root='true'
endif


let loaded_matchparen = 1
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:completion_enable_snippet = 'vim-vsnip'


" Save & quit
noremap Q :q<CR>
noremap <A-s> :w<CR>

nnoremap <leader>f :s/<C-R>=expand("<cword>")<CR>/
" nnoremap <leader>pv :CocCommand explorer<CR>
nnoremap <leader>pv :Ex<CR>
nnoremap <leader>pp :CocCommand explorer --position floating<CR>
nnoremap <Leader><CR> :so <C-R>=<SID>sourceInit()<CR><CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oconsole.log()<esc>i

" coc-translator
nmap ts <Plug>(coc-translator-p)

" inoremap <silent><expr> <Tab>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<Tab>" :
"       \ coc#refresh()
"
" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

function! s:sourceInit () abort
    if empty($XDG_CONFIG_HOME)
         return $HOME . '/.config/nvim/init.vim'
    else
        return $XDG_CONFIG_HOME . '/nvim/init.vim'
    endif
endfunction

" inoremap <silent><expr> <C-space> coc#refresh()
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
" command! -nargs=0 Eslint :CocCommand eslint.executeAutofix


" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" greatest remap ever
vnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>Y gg"+yG

inoremap <C-c> <esc>



" insert keymap like emacs {{
" inoremap <C-w> <C-[>diwa
inoremap <C-d> <Del>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"
" }}}


function s:exit_to_normal() abort
    if &filetype ==# 'fzf'
        return "\<Esc>"
    endif
    return "\<C-\>\<C-n>"
endfunction
tnoremap <expr> <Esc> <SID>exit_to_normal()

function s:scan() abort
  let l:stack = synstack(line('.'), col('.'))
  for l:name in l:stack
    echo synIDattr(l:name, 'name')
  endfor
endfunction

noremap <leader>v :call <SID>scan()<CR>

let g:tcomment#replacements_xml={}

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup LQF autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
"
" autocmd CursorHold * silent call CocActionAsync('highlight')
