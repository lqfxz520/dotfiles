call plug#begin('~/.vim/plugged')

Plug 'cohama/lexima.vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'JoosepAlviste/nvim-ts-context-commentstring', {'branch': 'main'}
Plug 'theHamsta/nvim-treesitter-pairs'
Plug 'windwp/nvim-ts-autotag', {'branch': 'main'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'vuciv/vim-bujo'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'skywind3000/vim-terminal-help'

Plug 'gruvbox-community/gruvbox'
Plug 'overcache/NeoSolarized'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'sainnhe/gruvbox-material'
" Plug 'vim-airline/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline-themes'
Plug 'hardcoreplayers/oceanic-material'
Plug 'phanviet/vim-monokai-pro'
" Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

Plug 'puremourning/vimspector'

call plug#end()


lua require("lqf")

    " \ 'coc-tabnine',
let g:coc_global_extensions=[
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-vetur',
    \ 'coc-prettier',
    \ 'coc-html',
    \ 'coc-emmet',
    \ 'coc-explorer',
    \ 'coc-translator',
    \ 'coc-eslint',
    \ 'coc-snippets',
 \ ]

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

" Save & quit
noremap Q :q<CR>
noremap <A-s> :w<CR>

nnoremap <leader>f :s/<C-R>=expand("<cword>")<CR>/
" nnoremap <leader>pv :CocCommand explorer<CR>
nnoremap <leader>pv :CocCommand explorer<CR>
nnoremap <leader>pp :CocCommand explorer --position floating<CR>
nnoremap <Leader><CR> :so <C-R>=<SID>sourceInit()<CR><CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oconsole.log()<esc>i

" coc-translator
nmap ts <Plug>(coc-translator-p)

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

let g:tcomment#filetype#guess_vue = 0
let g:vimspector_enable_mappings = 'HUMAN'

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup LQF autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

augroup fmt
  autocmd!
  autocmd BufWritePre * Format
augroup END
"
" autocmd CursorHold * silent call CocActionAsync('highlight')
