syntax on

set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
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
set signcolumn=yes

set scrolloff=3
set sidescrolloff=5

set foldenable
set foldlevelstart=99
set foldmethod=expr  " folding by syntax regions
set foldexpr=nvim_treesitter#foldexpr()

set showmatch           " Jump to matching bracket
" set matchpairs+=<:>     " Add HTML brackets to pair matching
set matchtime=1         " Tenths of a second to show the matching paren

set pumheight=15        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=12    " Completion preview height

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=250
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
set cursorline
"
" spaceline {{{
set list
set listchars=nbsp:█,tab:›\ ,trail:-,extends:#
" }}} spaceline

" syntax {{{
set synmaxcol=300
" }}} syntax

" mouse {{{
set mouse=nv
set mousehide
" }}} mouse

" guicursor {{{
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
            \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
            \,sm:block-blinkwait175-blinkoff150-blinkon175
" }}} guicursor

set jumpoptions=stack
set completeopt=menu,menuone,noselect
set formatoptions=jcrql
