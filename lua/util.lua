local fn, api = vim.fn, vim.api

_G.Util = {}

P = function(stuff)
  print(vim.inspect(stuff))
  return stuff
end

Util.borders = {
  -- fancy border
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },

  -- padding border
  -- {"▄", "Bordaa"},
  -- {"▄", "Bordaa"},
  -- {"▄", "Bordaa"},
  -- {"█", "Bordaa"},
  -- {"▀", "Bordaa"},
  -- {"▀", "Bordaa"},
  -- {"▀", "Bordaa"},
  -- {"█", "Bordaa"}
}

Util.lsp_on_init = function(client)
  if
    client.name == "svelte"
    or client.name == "volar"
    or client.name == "tsserver"
  then
    client.resolved_capabilities.document_formatting = false
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

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    ]]
  end

  require("lqf1.mappings").lsp_mappings(bufnr)
end

return Util
