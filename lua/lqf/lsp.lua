local on_attach = require'completion'.on_attach
require'lspconfig'.tsserver.setup{on_attach=on_attach}
require'lspconfig'.vuels.setup{on_attach=on_attach}
require'lspconfig'.cssls.setup{on_attach=on_attach}
require'lspconfig'.html.setup{on_attach=on_attach}
require'lspconfig'.jsonls.setup{on_attach=on_attach}

