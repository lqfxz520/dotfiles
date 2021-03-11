
call plug#begin('~/.vim/plugged')

" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Plug 'tjdevries/nlua.nvim'
" Plug 'tjdevries/lsp_extensions.nvim'



Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'




Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tweekmonster/gofmt.vim'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
" Plug 'sheerun/vim-polyglot'
Plug 'cakebaker/scss-syntax.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vuciv/vim-bujo'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'
Plug 'skywind3000/vim-terminal-help'
Plug 'Yggdroot/indentLine'

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
    \ 'coc-highlight',
    \ 'coc-tabnine'
 \ ]


" Pseudo-transparency for completion menu and floating windows
if exists('&pumblend')
   if &termguicolors
       set pumblend=15
   endif
   if exists('&winblend')
       set winblend=15
   endif
endif


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

" float windows
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Save & quit
noremap Q :q<CR>
" noremap S :w<CR>
noremap <A-s> :w<CR>

" nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
" nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
" nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>
" nnoremap <Leader>ps :Rg<SPACE>
" nnoremap <C-p> :GFiles<CR>
" nnoremap <Leader>pf :Files<CR>
nnoremap <leader>f :s/<C-R>=expand("<cword>")<CR>/
nnoremap <leader>pv :CocCommand explorer<CR>
nnoremap <leader>pp :CocCommand explorer --position floating<CR>
nnoremap <Leader><CR> :so <C-R>=<SID>sourceInit()<CR><CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>




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


" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
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
command! -nargs=0 Eslint :CocCommand eslint.executeAutofix


" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

vnoremap X "_d
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

let g:vue_pre_processor = ['scss', 'less']

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
autocmd CursorHold * silent call CocActionAsync('highlight')
