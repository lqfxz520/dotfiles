local lsp = require('control.lsp')
local fmt = require('features.format')

---@type Feature
local go = {
  pre = function()
    fmt.by_formatter.go = { fmt.formatters.goimports }
  end,
  plugins = {
    {
      'ray-x/go.nvim',
      ft = { 'go', 'gomod' },
      config = function()
        require('go').setup()
      end,
    },
  },
  post = function()
    lsp.set_config('gopls', {})
    lsp.set_config('golangci_lint_ls', {})
  end,
}

---@type Feature
local json = {
  pre = function()
    fmt.by_formatter.json = { fmt.formatters.prettier }
  end,
  post = function()
    local jsonls = {
      settings = {
        json = {
          schemas = {
            {
              fileMatch = { 'package.json' },
              url = 'https://json.schemastore.org/package.json',
            },
            {
              fileMatch = { 'jsconfig*.json' },
              url = 'https://json.schemastore.org/jsconfig.json',
            },
            {
              fileMatch = { 'tsconfig*.json' },
              url = 'https://json.schemastore.org/tsconfig.json',
            },
            {
              fileMatch = {
                '.prettierrc',
                '.prettierrc.json',
                'prettier.config.json',
              },
              url = 'https://json.schemastore.org/prettierrc.json',
            },
            {
              fileMatch = { '.eslintrc', '.eslintrc.json' },
              url = 'https://json.schemastore.org/eslintrc.json',
            },
            {
              fileMatch = { 'nodemon.json' },
              url = 'https://json.schemastore.org/nodemon.json',
            },
          },
        },
      },
    }
    lsp.set_config('jsonls', jsonls)
  end,
}

---@type Feature
local lua = {
  pre = function()
    fmt.by_formatter.lua = { fmt.formatters.stylua }
  end,
  post = function()
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    local function workspace_files()
      local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
      if cwd == '~/.config/nvim' then
        -- Make the server aware of Neovim runtime files, only in config cwd
        return vim.api.nvim_get_runtime_file('', true)
      end
      return nil
    end

    local sumneko_lua_settings = {
      cmd = { 'lua-language-server' },
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = runtime_path,
          },
          completion = {
            autoRequire = false,
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = workspace_files(),
            maxPreload = 5000,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    }
    lsp.set_config('sumneko_lua', sumneko_lua_settings)
  end,
}

---@type Feature
local markdown = {
  pre = function()
    fmt.by_formatter.markdown = { fmt.formatters.prettier }
  end,
}

---@type Feature
local typescript = {
  pre = function()
    fmt.by_formatter.typescript = { fmt.formatters.prettier }
    fmt.by_formatter.javascript = { fmt.formatters.prettier }
    fmt.by_formatter.typescriptreact = { fmt.formatters.prettier }
    fmt.by_formatter.javascriptreact = { fmt.formatters.prettier }
    fmt.by_formatter.css = { fmt.formatters.prettier }
    fmt.by_formatter.html = { fmt.formatters.prettier }
    fmt.by_formatter.vue = { fmt.formatters.prettier }
  end,
  plugins = {
    {
      'mattn/emmet-vim',
      ft = { 'html', 'javascript.jsx', 'typescript.tsx', 'javascriptreact', 'typescriptreact', 'vue' },
    },
  },
  post = function()
    local util = require('lspconfig.util')
    -- lsp.set_config('tsserver', {
    -- root_dir = function(fname)
    -- return util.root_pattern('tsconfig.json')(fname) or util.root_pattern('package.json', 'jsconfig.json')(fname)
    -- end,
    -- })
    local function get_typescript_server_path(root_dir)
      local project_root = util.find_node_modules_ancestor(root_dir)

      local local_tsserverlib = project_root ~= nil
        and util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
      local global_tsserverlib = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'

      if local_tsserverlib and util.path.exists(local_tsserverlib) then
        return local_tsserverlib
      else
        return global_tsserverlib
      end
    end
    lsp.set_config('volar', {
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
      on_new_config = function(new_config, new_root_dir)
        new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
      end,
    })

    lsp.set_config('tailwindcss', {
      root_dir = util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
    })

    lsp.set_config('denols', {
      root_dir = util.root_pattern('deno_root'),
      init_options = {
        enable = true,
        lint = true,
        unstable = true,
      },
    })
    lsp.set_config('graphql', {
      filetypes = { 'graphql' },
    })
    -- lsp.set_config('eslint', {})
  end,
}

---@type Feature
local viml = {
  post = function()
    lsp.set_config('vimls', {})
  end,
}

---@type Feature
local yaml = {
  pre = function()
    fmt.by_formatter.yaml = { fmt.formatters.prettier }
  end,
  post = function()
    lsp.set_config('yamlls', {})
  end,
}

---@type Feature[]
return {
  go,
  json,
  lua,
  markdown,
  typescript,
  viml,
  yaml,
}
