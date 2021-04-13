set completeopt=menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']


" nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
" nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
" nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
" nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
" nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
" nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
" nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
" nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
" nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <leader>vll :lua vim.lsp.diagnostic.set_loclist()<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <leader>vp <Plug>(coc-diagnostic-prev)
nnoremap <leader>vn <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nnoremap <leader>vd <Plug>(coc-definition)
nnoremap <leader>vy <Plug>(coc-type-definition)
nnoremap <leader>vi <Plug>(coc-implementation)
nnoremap <leader>vrr <Plug>(coc-references)
nnoremap <leader>vrn <Plug>(coc-rename)
nnoremap <leader>vll :<C-u>CocList diagnostics<cr>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>vca  <Plug>(coc-codeaction-selected)
nmap <leader>vca  <Plug>(coc-codeaction-selected)

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
inoremap <c-x><c-i> coc#refresh()
