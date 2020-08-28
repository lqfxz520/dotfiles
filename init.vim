" ===
" === Auto load for first time uses
" ===
let basePath = ! empty($XDG_DATA_HOME) ? $XDG_DATA_HOME : $HOME . '/.local/share'
if empty(glob(basePath . '/nvim/site/autoload/plug.vim'))
    echo basePath
    silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

syntax on

set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set noshowmode
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set clipboard=unnamedplus

set scrolloff=3
set sidescrolloff=5

set foldenable
set foldlevelstart=99
set foldmethod=syntax  " folding by syntax regions

set showmatch           " Jump to matching bracket
set matchpairs+=<:>     " Add HTML brackets to pair matching
set matchtime=1         " Tenths of a second to show the matching paren

set pumheight=15        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=12    " Completion preview height

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tweekmonster/gofmt.vim'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vuciv/vim-bujo'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'

Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'hardcoreplayers/oceanic-material'


call plug#end()
let g:coc_global_extensions=[
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-vetur',
    \ 'coc-prettier',
    \ 'coc-html',
    \ 'coc-emmet',
    \ 'coc-explorer',
    \ 'coc-translator',
 \ ]

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" --- vim go (polyglot) settings.
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

" Pseudo-transparency for completion menu and floating windows
if exists('&pumblend')
   if &termguicolors
       set pumblend=15
   endif
   if exists('&winblend')
       set winblend=15
   endif
endif

let g:gruvbox_invert_selection=0
let g:gruvbox_contrast_dark = 'hard'

colorscheme gruvbox
set background=dark

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

" float windows
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Save & quit
noremap Q :q<CR>
noremap S :w<CR>

nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :CocCommand explorer --toggle<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader><CR> :so <C-R>=<SID>sourceInit()<CR><CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
nnoremap <Left> :tabp<CR>
nnoremap <Right> :tabn<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart<CR>

" Formatting selected code.
nmap <leader>f  <Plug>(coc-format-selected)
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>qf  <Plug>(coc-fix-current)
" coc-translator
nmap ts <Plug>(coc-translator-p)

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:sourceInit () abort
    if empty($XDG_CONFIG_HOME)
         return $HOME . '/.config/nvim/init.vim'
    else
        return $XDG_CONFIG_HOME . '/nvim/init.vim'
    endif
endfunction

inoremap <silent><expr> <C-space> coc#refresh()
command! -nargs=0 Prettier :CocCommand prettier.formatFile


" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

vnoremap X "_d
inoremap <C-c> <esc>

" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>
nmap <leader>gc :G log -p %<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 50)
augroup END

autocmd BufWritePre * :call TrimWhitespace()

" spaceline {{{
set list
set listchars=tab:›\ ,trail:-,extends:#,nbsp:.
" }}} spaceline

" syntax {{{
set synmaxcol=1000
" }}} syntax

" mouse {{{
set mouse+=a
set mousehide
" }}} mouse

" guicursor {{{
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
            \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
            \,sm:block-blinkwait175-blinkoff150-blinkon175
" }}} guicursor

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
