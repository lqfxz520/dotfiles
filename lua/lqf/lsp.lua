local on_attach = require'completion'.on_attach
require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.vuels.setup{on_attach=require'completion'.on_attach}

local util = require 'lspconfig/util'.root_pattern("package.json", "vue.config.js")
print {util}
