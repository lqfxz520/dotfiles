local on_attach = require'completion'.on_attach
echo l:on_attach
require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
