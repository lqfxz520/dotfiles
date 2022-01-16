" CSS classes usually have dashes in them, so the whole class name should be
" considered as a word
setlocal iskeyword+=-

" Mappings for navigating blocks
nnoremap <silent><buffer> ]] :call search('^<\(template\<bar>script\<bar>style\)', 'W')<cr>
nnoremap <silent><buffer> [[ :call search('^<\(template\<bar>script\<bar>style\)', 'bW')<cr>

let s:dnum = search('\<data()\|\<\(data: () =>\)', 'nW')
let s:mnum = search('\<methods:', 'nW')
let s:cnum = search('\<created()', 'nW')

if s:dnum != 0
    exe s:dnum .. "ma d"
endif
if s:mnum != 0
    exe s:mnum .. "ma m"
endif
if s:cnum != 0
    exe s:cnum .. "ma c"
endif

