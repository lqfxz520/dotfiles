require'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
    indent = { enable = true },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"},
    },
    playground = {
        disable = {},
        enable = true,
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    context_commentstring = {
        enable = true,
    },
    pairs = {
        enable = true,
        disable = {},
        highlight_pair_events = {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
        highlight_self = false,
        goto_right_end = false, -- whether to go to the end of the right partner or the beginning
        fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
        keymaps = {
            goto_partner = "%"
        }
    },
    autotag = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                -- Or you can define your own textobjects like this
                ["iF"] = {
                    python = "(function_definition) @function",
                    cpp = "(function_definition) @function",
                    c = "(function_definition) @function",
                    java = "(method_declaration) @function",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<Leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<Leader>A"] = "@parameter.inner",
                },
            },
            lsp_interop = {
                enable = true,
            },       },
    },
}
