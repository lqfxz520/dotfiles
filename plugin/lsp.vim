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
nmap <leader>vd <Plug>(coc-definition)
nmap <leader>vy <Plug>(coc-type-definition)
nmap <leader>vi <Plug>(coc-implementation)
nmap <leader>vrr <Plug>(coc-references)
nmap <leader>vrn <Plug>(coc-rename)
nmap <leader>vll :<C-u>CocList diagnostics<cr>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
nmap <silent> <leader>a <Plug>(coc-codeaction-cursor)
nmap <silent> ga <Plug>(coc-codeaction-line)
nmap <silent> gA <Plug>(coc-codeaction)

" nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>
inoremap <silent><expr> <c-x><c-i> coc#refresh()
