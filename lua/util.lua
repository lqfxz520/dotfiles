local fn, api = vim.fn, vim.api

_G.Util = {}

Util.P = function(stuff)
  print(vim.inspect(stuff))
  return stuff
end

Util.borders = {
  -- fancy border
  -- { "🭽", "FloatBorder" },
  -- { "▔", "FloatBorder" },
  -- { "🭾", "FloatBorder" },
  -- { "▕", "FloatBorder" },
  -- { "🭿", "FloatBorder" },
  -- { "▁", "FloatBorder" },
  -- { "🭼", "FloatBorder" },
  -- { "▏", "FloatBorder" },

  -- padding border
  { "▄", "Bordaa" },
  { "▄", "Bordaa" },
  { "▄", "Bordaa" },
  { "█", "Bordaa" },
  { "▀", "Bordaa" },
  { "▀", "Bordaa" },
  { "▀", "Bordaa" },
  { "█", "Bordaa" },
}

Util.lsp_on_init = function(client)
  if
    client.name == "svelte"
    or client.name == "volar"
    or client.name == "vuels"
    or client.name == "tsserver"
  then
    client.resolved_capabilities.document_formatting = false
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end

  vim.notify(
    client.name .. ": Language Server Client successfully started!",
    "info"
  )
end

Util.lsp_on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    local ts_utils = require "nvim-lsp-ts-utils"
    ts_utils.setup {
      auto_inlay_hints = false, -- enable this once #9496 got merged
      enable_import_on_completion = true,
    }
    ts_utils.setup_client(client)
  end

  if client.resolved_capabilities.code_lens then
    vim.cmd [[
    augroup CodeLens
      au!
      au InsertEnter,InsertLeave * lua vim.lsp.codelens.refresh()
    augroup END
    ]]
  end

  -- if client.resolved_capabilities.document_highlight then
  --   vim.cmd [[
  --     autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
  --     autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
  --     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --   ]]
  -- end

  require("lsp.mappings").lsp_mappings(bufnr)
end

-- Util.startVolar = function()
--   require("lspconfig").volar.setup {
--     cmd = {
--       "node",
--       "/usr/local/lib/node_modules/@volar/server/out/index.js",
--       "--stdio",
--       "--max-old-space-size=4096",
--     },
--     on_new_config = function(new_config, new_root_dir)
--       new_config.init_options.typescript.serverPath =
--         get_typescript_server_path(
--           new_root_dir
--         )
--     end,
--   }
-- end

Util.startVetur = function()
  require("lspconfig").vuels.setup {
    cmd = { "vls" },
    on_attach = Util.lsp_on_attach,
    capabilities = require("cmp_nvim_lsp").update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    filetypes = { "vue" },
    init_options = {
      config = {
        css = {},
        emmet = {},
        html = {
          suggest = {},
        },
        javascript = {
          format = {},
        },
        stylusSupremacy = {},
        typescript = {
          format = {},
        },
        vetur = {
          completion = {
            autoImport = false,
            tagCasing = "kebab",
            useScaffoldSnippets = false,
          },
          format = {
            defaultFormatter = {
              js = "none",
              ts = "none",
            },
            defaultFormatterOptions = {},
            scriptInitialIndent = false,
            styleInitialIndent = false,
          },
          useWorkspaceDependencies = false,
          validation = {
            script = true,
            style = true,
            template = true,
          },
        },
      },
    },
  }
end

return Util
