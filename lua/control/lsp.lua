---@class LspModule
---@field keys LspKeyMappers
---@field buffer_keys LspKeyMappers
---@field on_attaches OnAttachFn[]

---@class LspKeyMapper
---@field [1] string key
---@field [2] string command
---@field [3] string introduce

---@alias LspKeyMappers table<string, LspKeyMapper>
---@alias OnAttachFn function(client:table,bufnr:number)
---@alias CapsSetter function(caps:table):table

-- local opts = { noremap=true, silent=true }

---@type LspModule
local lsp = {
  keys = {
    diag_float = { '<leader>e', vim.diagnostic.open_float, 'Open diagnostic floating window' },
    diag_prev = { '[d', vim.diagnostic.goto_prev, 'Goto prev diagnostic' },
    diag_next = { ']d', vim.diagnostic.goto_next, 'Goto next diagnostic' },
    diag_loclist = { '<leader>q', vim.diagnostic.setloclist, 'Add buffer diagnostics to the location list.' },
  },
  buffer_keys = {
    goto_decl = { 'vD', vim.lsp.buf.declaration, 'Goto declaration' },
    goto_def = { 'vd', vim.lsp.buf.definition, 'Goto definition' },
    hover = { 'K', vim.lsp.buf.hover, 'Display hover information' },
    goto_impl = { 'gi', vim.lsp.buf.implementation, 'Goto implementation' },
    sign_help = { '<C-k>', vim.lsp.buf.signature_help, 'Display signature information' },
    add_folder = { '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
    del_folder = { '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
    list_folders = {
      '<leader>wl',
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      'List workspace folder',
    },
    type_def = { '<leader>D', vim.lsp.buf.type_definition, 'Goto type definition' },
    rename = { '<leader>rn', vim.lsp.buf.rename, 'Rename symbol' },
    code_action = { '<leader>ga', vim.lsp.buf.code_action, 'Code action' },
    list_ref = { 'gr', vim.lsp.buf.references, 'List references' },
    -- format = { '<leader>f', vim.lsp.buf.formatting, 'Format buffer' },
  },
  on_attaches = {},
  caps_setters = {},
}

---set lsp function of the key
---@param mapper LspKeyMapper
---@param command string
function lsp.set_key_cmd(mapper, command)
  mapper[2] = command
end

---set lsp key of the function
---@param mapper LspKeyMapper
---@param key string
function lsp.set_cmd_key(mapper, key)
  mapper[1] = key
end

---add 'on_attach' hook
---@param fn OnAttachFn
function lsp.add_on_attach(fn)
  lsp.on_attaches[#lsp.on_attaches + 1] = fn
end

---mapping lsp keys
---@param bufnr number buffer number
local function mapping(bufnr)
  local wk = require('which-key')
  local mappings = {}
  for _, mapper in pairs(lsp.keys) do
    mappings[mapper[1]] = { mapper[2], mapper[3] }
  end
  wk.register(mappings, { silent = true })

  local buf_mappings = {}
  for _, mapper in pairs(lsp.buffer_keys) do
    buf_mappings[mapper[1]] = { mapper[2], mapper[3] }
  end
  wk.register(buf_mappings, { buffer = bufnr })
end

---on attach function
---@param client table client object
---@param bufnr number buffer number
local function on_attach(client, bufnr)
  mapping(bufnr)
  for _, fn in ipairs(lsp.on_attaches) do
    fn(client, bufnr)
  end
end

---add a capabilities setter
---@param setter CapsSetter
function lsp.add_caps_setter(setter)
  lsp.caps_setters[#lsp.caps_setters + 1] = setter
end

local function capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()
  caps.textDocument.completion.completionItem.snippetSupport = true
  caps.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
  }
  for _, setter in ipairs(lsp.caps_setters) do
    caps = setter(caps)
  end
  return caps
end

---set lsp config
---@param name string language server string
---@param config table language server config
function lsp.set_config(name, config)
  local lspconfig = require('lspconfig')
  config.on_attach = on_attach
  config.capabilities = capabilities()
  lspconfig[name].setup(config)
end

function lsp.add_default(name, default_config)
  local configs = require('lspconfig.configs')
  if not configs[name] then
    configs[name] = {
      default_config = default_config,
    }
  end
end

function lsp.stop_all_clients()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
end

return lsp
