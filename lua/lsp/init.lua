local nvim_lsp = require "lspconfig"
local nvim_util = require "lspconfig.util"
require "lsp.handlers"

local function get_typescript_server_path(root_dir)
  local project_root = nvim_util.find_node_modules_ancestor(root_dir)

  local local_tsserverlib = project_root ~= nil
    and nvim_util.path.join(
      project_root,
      "node_modules",
      "typescript",
      "lib",
      "tsserverlibrary.js"
    )
  local global_tsserverlib =
    "/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js"

  if local_tsserverlib and nvim_util.path.exists(local_tsserverlib) then
    return local_tsserverlib
  else
    return global_tsserverlib
  end
end

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
    filetypes = { "css", "scss", "less", "vue" },
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
  -- volar = {
  --   cmd = { 'node', '/usr/local/lib/node_modules/@volar/server/out/index.js', '--stdio', '--max-old-space-size=4096' },
  --   init_options = {},
  --   on_new_config = function(new_config, new_root_dir)
  --     new_config.init_options.typescript.serverPath =
  --       get_typescript_server_path(
  --         new_root_dir
  --       )
  --   end,
  -- },
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
          rootPatterns = { ".git" },
          debounce = 100,
          args = {
            "--stdin",
            "--stdin-filename",
            "%filepath",
            "--format",
            "json",
          },
          sourceName = "eslint_d",
          parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "[eslint] ${message} [${ruleId}]",
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
          rootPatterns = { ".git" },
          args = {
            "--stdin",
            "--stdin-filename",
            "%filename",
            "--fix-to-stdout",
          },
        },
        prettier = {
          command = "prettier",
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
        stylua = {
          command = "stylua",
          rootPatterns = { ".git" },
          args = { "-" },
        },
      },
      formatFiletypes = {
        css = "prettier",
        javascript = "prettier",
        javascriptreact = "prettier",
        json = "prettier",
        scss = "prettier",
        less = "prettier",
        typescript = "prettier",
        typescriptreact = "prettier",
        markdown = "prettier",
        vue = { "eslint_d", "prettier" },
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
