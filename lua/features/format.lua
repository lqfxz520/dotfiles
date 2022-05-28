---@type Feature
local format = {
  by_formatter = {},
  by_lsp = {},
}

format.formatters = {
  prettier = function()
    return {
      exe = 'prettier',
      args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
      stdin = true,
    }
  end,
  stylua = function()
    return {
      exe = 'stylua',
      args = { '-' },
      stdin = true,
    }
  end,
}

format.plugins = {
  {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local formatting = require('null-ls').builtins.formatting
      local diagnostics = require('null-ls').builtins.diagnostics
      local code_actions = require('null-ls').builtins.code_actions
      local group = vim.api.nvim_create_augroup('format_on_save', {})
      -- only null-ls formatters are applied
      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          bufnr = bufnr,
          name = 'null-ls',
        })
      end
      local condition = function(files)
        return function(utils)
          return utils.root_has_file(files)
        end
      end
      require('null-ls').setup({
        sources = {
          formatting.stylua,
          formatting.prettier.with({
            condition = condition({
              '.prettierrc',
              '.prettierrc.json',
              '.prettierrc.js',
              'prettier.config.js',
              'prettier.config.cjs',
            }),
          }),
          diagnostics.eslint_d.with({
            condition = condition({ '.eslintrc.js', '.eslintrc.json', '.eslintrc.cjs', '.eslintrc.yaml' }),
          }),
          formatting.eslint_d.with({
            condition = condition({ '.eslintrc.js', '.eslintrc.json', '.eslintrc.cjs', '.eslintrc.yaml' }),
          }),
          code_actions.eslint_d,
        },
        on_attach = function(client, bufnr)
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = group,
              buffer = bufnr,
              callback = function()
                lsp_formatting(bufnr)
              end,
            })
          end
        end,
      })
    end,
  },
  -- {
  --   'mhartington/formatter.nvim',
  --   config = function()
  --     local fmt = require('features.format')
  --     require('formatter').setup({
  --       filetype = fmt.by_formatter,
  --     })
  --     local group = vim.api.nvim_create_augroup('format_on_save', {})
  --     -- vim.api.nvim_create_autocmd('BufWritePost', {
  --     --   group = group,
  --     --   pattern = '*',
  --     --   command = 'silent! FormatWrite',
  --     -- })
  --     -- vim.api.nvim_create_autocmd('BufWritePost', {
  --     --   group = group,
  --     --   pattern = table.concat(fmt.by_lsp, ','),
  --     --   callback = vim.lsp.buf.formatting_seq_sync,
  --     -- })
  --     vim.api.nvim_create_autocmd('BufWritePre', {
  --       group = group,
  --       pattern = '*.tsx,*.ts,*.jsx,*.js,*vue',
  --       command = 'silent! EslintFixAll',
  --     })
  --   end,
  -- },
}

return format
