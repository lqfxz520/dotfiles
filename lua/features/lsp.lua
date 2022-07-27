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
lsp.plugins[#lsp.plugins+1] = {
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
lsp.plugins[#lsp.plugins + 1] = {
  'ray-x/lsp_signature.nvim',
  config = function()
    require('control.lsp').add_on_attach(function(_, bufnr)
      require('lsp_signature').on_attach({
        bind = true,
        handler_opts = { border = 'rounded' },
      }, bufnr)
    end)
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
