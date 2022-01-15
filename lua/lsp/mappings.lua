local map = vim.api.nvim_buf_set_keymap
local telescope = require "telescope.builtin"

local M = {}

M.lsp_mappings = function(bufnr)
  map(bufnr, "i", "<C-s>", "<cmd>vim.lsp.buf.signature_help()<CR>", {
    -- callback = vim.lsp.buf.signature_help,
    -- desc = "Trigger signature help from the language server",
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {
    -- callback = vim.lsp.buf.hover,
    -- desc = "Trigger hover window from the language server",
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", {
    -- callback = vim.lsp.buf.code_action,
    -- desc = "Pick code actions from the language server",
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", {
    -- callback = vim.lsp.buf.formatting,
    -- desc = "Format current document",
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>vd", "<cmd>lua vim.lsp.buf.definition()<CR>", {
    -- callback = vim.lsp.buf.definition,
    -- desc = "Go to symbol definition",
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>gl", "<cmd>lua vim.lsp.codelens.run()<CR>", {
    -- callback = vim.lsp.codelens.run,
    -- desc = "Run codelens from the language server",
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>gD", "<cmd>lua vim.diagnostic.open_float(0, { show_header = false, border = Util.borders, severity_sort = true, scope = 'line', })<CR>", {
    -- callback = function()
    --   vim.diagnostic.open_float(0, {
    --     show_header = false,
    --     border = Util.borders,
    --     severity_sort = true,
    --     scope = "line",
    --   })
    -- end,
    -- desc = "See diagnostics in floating window",
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>vr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", {
    -- callback = telescope.lsp_references,
    -- desc = "Find symbol references using telescope",
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>", {
    -- callback = vim.lsp.buf.rename,
    -- desc = "Rename current symbol",
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>g]", "<cmd>lua vim.diagnostic.goto_next { float = { show_header = false, border = Util.borders }, }<CR>", {
    -- callback = function()
    --   vim.diagnostic.goto_next {
    --     float = { show_header = false, border = Util.borders },
    --   }
    -- end,
    -- desc = "Go to next diagnostic",
    noremap = true,
    silent = true,
  })

  map(bufnr, "n", "<Leader>g[", "<cmd>lua vim.diagnostic.goto_prev { float = { show_header = false, border = Util.borders }, }<CR>", {
    -- callback = function()
    --   vim.diagnostic.goto_prev {
    --     float = { show_header = false, border = Util.borders },
    --   }
    -- end,
    -- desc = "Go to previous diagnostic",
    noremap = true,
    silent = true,
  })
end

return M
