vim.lsp.set_log_level('debug')
local nvim_lsp = require('lspconfig')
local nvim_util = require('lspconfig.util')
local protocol = require'vim.lsp.protocol'

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  --Mappings
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>vD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>vd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>vi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>vr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  --formatting
  -- if client.name == 'tsserver' then
  --     client.resolved_capabilities.document_formatting =false
  -- end

   --protocol.SymbolKind = { }
  protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }
end

local function get_typescript_server_path(root_dir)
  local project_root = util.find_node_modules_ancestor(root_dir)

  local local_tsserverlib = project_root ~= nil and util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
  local global_tsserverlib = '/home/kiteboy/.npm/lib/node_modules/typescript/lib/tsserverlibrary.js'

  if local_tsserverlib and util.path.exists(local_tsserverlib) then
    return local_tsserverlib
  else
    return global_tsserverlib
  end
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

local servers = {
    tsserver = {
        init_options = vim.tbl_deep_extend(
            'force',
            require('nvim-lsp-ts-utils').init_options,
            {
                documentFormatting = false,
            }
        )
    },
    html = {
        cmd = { 'vscode-html-language-server', '--stdio' },
    },
    cssls = {
        cmd = { "vscode-css-language-server", "--stdio" },
    },
    volar = {
        config = {
            on_new_config = function(new_config, new_root_dir)
                print(123)
                new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
            end,
        },
    },

}

for name, opts in pairs(servers) do
    if type(opts) == 'function' then
        opts()
    else
        nvim_lsp[name].setup(vim.tbl_extend("force", {
            flags = { debounce_text_changes = 150 },
            on_attach = on_attach,
            capabilities = capabilities,
        }, opts))
    end
end

-- nvim_lsp.diagnosticls.setup {
--     on_attach = on_attach,
--     filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
--     init_options = {
--         linters = {
--             eslint = {
--                 command = 'eslint',
--                 rootPatterns = { '.git' },
--                 debounce = 100,
--                 args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
--                 sourceName = 'eslint',
--                 parseJson = {
--                     errorsRoot = '[0].messages',
--                     line = 'line',
--                     column = 'column',
--                     endLine = 'endLine',
--                     endColumn = 'endColumn',
--                     message = '[eslint_test] ${message} [${ruleId}]',
--                     security = 'severity'
--                 },
--                 securities = {
--                     [2] = 'error',
--                     [1] = 'warning'
--                 }
--             },
--         },
--         filetypes = {
--             javascript = 'eslint',
--             javascriptreact = 'eslint',
--             typescript = 'eslint',
--             typescriptreact = 'eslint',
--             vue = 'eslint'
--         },
--         formatters = {
--             eslint_d = {
--                 command = 'eslint_d',
--                 rootPatterns = { '.git' },
--                 args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
--                 rootPatterns = { '.git' },
--             },
--             prettier = {
--                 command = 'prettier_d_slim',
--                 rootPatterns = { '.prettierrc', '.prettierrc.json', '.prettierrc.js', 'prettier.config.js', '.git' },
--                 -- requiredFiles: { 'prettier.config.js' },
--                 args = { '--stdin', '--stdin-filepath', '%filename' }
--             }
--         },
--         formatFiletypes = {
--             css = 'prettier',
--             javascript = 'prettier',
--             javascriptreact = 'prettier',
--             json = 'prettier',
--             scss = 'prettier',
--             less = 'prettier',
--             typescript = 'prettier',
--             typescriptreact = 'prettier',
--             json = 'prettier',
--             markdown = 'prettier',
--         }
--     }
-- }

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
        }
    ),
}

-- icon
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     -- This sets the spacing and the prefix, obviously.
--     virtual_text = {
--       spacing = 2,
--       prefix = ''
--     }
--   }
-- )

require("lqf.treesitter")
require("lqf.telescope")
-- require("lqf.lualine")
