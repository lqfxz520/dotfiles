local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;

local on_attach = require'completion'.on_attach
require'lspconfig'.tsserver.setup{on_attach=on_attach}
require'lspconfig'.vuels.setup{on_attach=on_attach}
require'lspconfig'.cssls.setup{
    on_attach=on_attach,
    capabilities = capabilities
}
require'lspconfig'.html.setup{
    on_attach=on_attach,
    capabilities = capabilities
}
require'lspconfig'.jsonls.setup{on_attach=on_attach}

