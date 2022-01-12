-- vim.lsp.set_log_level('debug')
local nvim_lsp = require('lspconfig')
local nvim_util = require('lspconfig.util')
local protocol = require'vim.lsp.protocol'

require "lqf1.handlers"

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
            "force",
            require("nvim-lsp-ts-utils").init_options,
            {
                preferences = {
                    importModuleSpecifierEnding = "auto",
                    importModuleSpecifierPreference = "shortest",
                },
                documentFormatting = false,
            }
        ),
        settings = {
            completions = {
                completeFunctionCalls = true,
            },
        },
    },
    html = {}, cssls = {}, volar = {
        config = {
            on_new_config = function(new_config, new_root_dir)
                print(123)
                new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
            end,
        },
    },
    diagnosticls = {
        on_attach = on_attach,
        filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'vue' },
        init_options = {
            linters = {
                eslint = {
                    command = 'eslint_d',
                    rootPatterns = { '.git' },
                    debounce = 100,
                    args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
                    sourceName = 'eslint_d',
                    parseJson = {
                        errorsRoot = '[0].messages',
                        line = 'line',
                        column = 'column',
                        endLine = 'endLine',
                        endColumn = 'endColumn',
                        message = '[eslint] ${message} [${ruleId}]',
                        security = 'severity'
                    },
                    securities = {
                        [2] = 'error',
                        [1] = 'warning'
                    }
                },
            },
            filetypes = {
                javascript = 'eslint',
                javascriptreact = 'eslint',
                typescript = 'eslint',
                typescriptreact = 'eslint',
            },
            formatters = {
                eslint_d = {
                    command = 'eslint_d',
                    rootPatterns = { '.git' },
                    args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
                    rootPatterns = { '.git' },
                },
                prettier = {
                    command = 'prettier_d_slim',
                    rootPatterns = { '.git' },
                    -- requiredFiles: { 'prettier.config.js' },
                    args = { '--stdin', '--stdin-filepath', '%filename' }
                }
            },
            formatFiletypes = {
                css = 'prettier',
                javascript = 'prettier',
                javascriptreact = 'prettier',
                json = 'prettier',
                scss = 'prettier',
                less = 'prettier',
                typescript = 'prettier',
                typescriptreact = 'prettier',
                json = 'prettier',
                markdown = 'prettier',
            }
        }
    }
}

for name, opts in pairs(servers) do
  if type(opts) == "function" then
    opts()
  else
    local client = nvim_lsp[name]

    client.setup(vim.tbl_extend("force", {
      flags = { debounce_text_changes = 150 },
      on_attach = Util.lsp_on_attach,
      on_init = Util.lsp_on_init,
      capabilities = capabilities,
    }, opts))
  end
end

-- nvim-cmp setup
require("plugin.comp").setup()

require("lqf.treesitter")
require("lqf.telescope")
-- require("lqf.lualine")
