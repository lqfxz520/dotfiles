---@type Feature
local lsp = { plugins = {} }

lsp.pre = function()
  local signs = { Error = '', Warn = '', Info = '', Hint = '' }
  for sign, text in pairs(signs) do
    local hl = 'DiagnosticSign' .. sign
    vim.fn.sign_define(hl, { text = text, texthl = hl, linehl = '', numhl = '' })
  end
  local border_opts = { border = 'rounded', focusable = false, scope = 'line' }
  local l = vim.lsp

  vim.diagnostic.config({ virtual_text = false, float = border_opts })

  l.handlers['textDocument/signatureHelp'] = l.with(l.handlers.signature_help, border_opts)
  l.handlers['textDocument/hover'] = l.with(l.handlers.hover, border_opts)
end

-- lsp diagnostics
lsp.plugins[1] = {
  'folke/trouble.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('trouble').setup({
      signs = { error = '', warning = '', hint = '', information = '', other = '﫠' },
    })
    require('which-key').register({
      ['<leader>x'] = {
        name = 'lsp trouble',
        x = { '<cmd>TroubleToggle<cr>', 'Toggle Trouble' },
        w = { '<cmd>Trouble workspace_diagnostics<cr>', 'Workspace diagnostics' },
        d = { '<cmd>Trouble document_diagnostics<cr>', 'Document diagnostics' },
        l = { '<cmd>Trouble loclist<cr>', "Items from the window's location list" },
        q = { '<cmd>Trouble quickfix<cr>', 'Quickfix items' },
      },
    })
  end,
}

-- function signature hint
lsp.plugins[2] = {
  'ray-x/lsp_signature.nvim',
  config = function()
    require('control.lsp').add_on_attach(function(_, _)
      require('lsp_signature').on_attach({
        bind = true,
        handler_opts = { border = 'rounded' },
      })
    end)
  end,
}

-- lsp ui extension
lsp.plugins[3] = {
  'RishabhRD/lspactions',
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
  },
  config = function()
    local lspactions = require('lspactions')
    vim.ui.select = lspactions.select
    vim.ui.input = lspactions.input
    vim.lsp.handlers['textDocument/codeAction'] = lspactions.codeaction
    vim.lsp.handlers['textDocument/references'] = lspactions.references
    vim.lsp.handlers['textDocument/definition'] = lspactions.definition
    vim.lsp.handlers['textDocument/declaration'] = lspactions.declaration
    vim.lsp.handlers['textDocument/implementation'] = lspactions.implementation
    local lsputil = require('control.lsp')
    lsputil.set_key_cmd(lsputil.buffer_keys.rename, lspactions.rename)
    lsputil.set_key_cmd(lsputil.buffer_keys.code_action, lspactions.code_action)
  end,
}

-- print lang server status
lsp.plugins[4] = {
  'j-hui/fidget.nvim',
  config = function()
    require('fidget').setup({})
  end,
}

return lsp