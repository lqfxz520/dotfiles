nnoremap <leader>pv :CocCommand explorer<CR>
nnoremap <leader>pp :CocCommand explorer --position floating<CR>
nnoremap <Leader><CR> :so <C-R>=<SID>sourceInit()<CR><CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <Leader>ee oconsole.log()<esc>i

" Save & quit
noremap Q :q<CR>
noremap <A-s> :w<CR>

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
