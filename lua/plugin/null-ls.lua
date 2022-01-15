local null_ls = require "null-ls"
local b = null_ls.builtins

null_ls.setup {
    debounce = 150,
    sources = {
        b.formatting.prettierd.with {
            filetypes = {
                "typescriptreact",
                "typescript",
                "javascriptreact",
                "javascript",
                "svelte",
                "json",
                "jsonc",
                "css",
                "html",
            },
        },
    },
}
