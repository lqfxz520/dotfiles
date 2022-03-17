local nvim_lsp = require "lspconfig"
require "lsp.handlers"

-- Set up completion using nvim_cmp with LSP source
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

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
  html = {},
  cssls = {
    -- filetypes = { "css", "scss", "less", "vue" },
  },
  jsonls = {
    settings = {
      json = {
        schemas = {
          {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json",
          },
          {
            fileMatch = { "jsconfig*.json" },
            url = "https://json.schemastore.org/jsconfig.json",
          },
          {
            fileMatch = { "tsconfig*.json" },
            url = "https://json.schemastore.org/tsconfig.json",
          },
          {
            fileMatch = {
              ".prettierrc",
              ".prettierrc.json",
              "prettier.config.json",
            },
            url = "https://json.schemastore.org/prettierrc.json",
          },
          {
            fileMatch = { ".eslintrc", ".eslintrc.json" },
            url = "https://json.schemastore.org/eslintrc.json",
          },
          {
            fileMatch = { "nodemon.json" },
            url = "https://json.schemastore.org/nodemon.json",
          },
        },
      },
    },
  },
  volar = {},
  diagnosticls = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "json",
      "typescript",
      "typescriptreact",
      "css",
      "less",
      "scss",
      "markdown",
      "vue",
      "lua",
    },
    init_options = {
      linters = {
        eslint = {
          command = "eslint_d",
          rootPatterns = {
            ".eslintrc.js",
            ".eslintrc.cjs",
            ".eslintrc.yaml",
            ".eslintrc.yml",
            ".eslintrc.json",
            "package.json",
          },
          debounce = 100,
          args = {
            "--stdin",
            "--stdin-filename",
            "%filepath",
            "--format",
            "json",
          },
          sourceName = "eslint",
          parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "${message} [${ruleId}]",
            security = "severity",
          },
          securities = {
            [2] = "error",
            [1] = "warning",
          },
        },
      },
      filetypes = {
        javascript = "eslint",
        javascriptreact = "eslint",
        typescript = "eslint",
        typescriptreact = "eslint",
        vue = "eslint",
      },
      formatters = {
        eslint_d = {
          command = "eslint_d",
          rootPatterns = {
            ".eslintrc",
            ".eslintrc.js",
            ".eslintrc.json",
            "eslint.config.js",
          },
          args = {
            "--stdin",
            "--stdin-filename",
            "%filename",
            "--fix-to-stdout",
          },
        },
        prettier = {
          command = "./node_modules/.bin/prettier",
          rootPatterns = {
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.toml",
            ".prettierrc.json",
            ".prettierrc.yml",
            ".prettierrc.yaml",
            ".prettierrc.json5",
            ".prettierrc.js",
            ".prettierrc.cjs",
            "prettier.config.js",
            "prettier.config.cjs",
          },
          -- requiredFiles: { 'prettier.config.js' },
          args = { "--stdin", "--stdin-filepath", "%filename" },
        },
        prettier_eslint = {
          command = "./node_modules/.bin/prettier-eslint",
          args = { "--stdin" },
          rootPatterns = { ".git" },
        },
        stylua = {
          command = "stylua",
          rootPatterns = { ".git" },
          args = { "-" },
        },
      },
      formatFiletypes = {
        css = "prettier",
        javascript = { "prettier", "eslint_d" },
        javascriptreact = { "prettier", "eslint_d" },
        json = "prettier",
        scss = "prettier",
        less = "prettier",
        typescript = { "prettier", "eslint_d" },
        typescriptreact = { "prettier", "eslint_d" },
        markdown = "prettier",
        vue = { "prettier", "eslint_d" },
        lua = "stylua",
      },
    },
  },
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

vim.api.nvim_set_keymap(
  "n",
  "<Leader>sv",
  "<cmd>lua Util.startVetur()<CR>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>sd",
  "<cmd>lua Util.startVolar()<CR>",
  { noremap = true }
)

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
