local on_attach = require'completion'.on_attach
require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.vuels.setup{on_attach=require'completion'.on_attach}

