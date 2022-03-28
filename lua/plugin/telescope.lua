local telescope = require "telescope"
local actions = require "telescope.actions"
local previewers = require "telescope.previewers"
local map = vim.api.nvim_set_keymap

local no_preview = function(opts)
  return vim.tbl_extend(
    "force",
    require("telescope.themes").get_dropdown {
      borderchars = {
        { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
        results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
        preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      },
      layout_config = {
        width = 0.6,
      },
      previewer = false,
    },
    opts or {}
  )
end

telescope.setup {
  defaults = {
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    scroll_strategy = "cycle",
    selection_strategy = "reset",
    layout_strategy = "flex",
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    layout_config = {
      horizontal = {
        width = 0.8,
        height = 0.8,
        preview_width = 0.6,
      },
      vertical = {
        height = 0.8,
        preview_height = 0.5,
      },
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-v>"] = actions.select_vertical,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-t>"] = actions.select_tab,

        ["<C-c>"] = actions.close,
        -- ["<Esc>"] = actions.close,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<Tab>"] = actions.toggle_selection,
        -- ["<C-r>"] = actions.refine_result,
      },
      n = {
        ["<CR>"] = actions.select_default + actions.center,
        ["<C-v>"] = actions.select_vertical,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-t>"] = actions.select_tab,
        ["<Esc>"] = actions.close,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-q>"] = actions.send_to_qflist,
        ["<Tab>"] = actions.toggle_selection,
      },
    },
  },
  pickers = {
    grep_string = {
      file_ignore_patterns = {
        "%.png",
        "%.jpg",
        "%.webp",
        "node_modules",
        "%.min.*",
      },
    },
    find_files = {
      file_ignore_patterns = {
        "%.png",
        "%.jpg",
        "%.webp",
        "node_modules",
        "%.min.*",
      },
    },
    lsp_code_actions = no_preview(),
    current_buffer_fuzzy_find = no_preview(),
  },
  extensions = {
    -- ["ui-select"] = no_preview(),
    fzf = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    frecency = {
      show_scores = true,
      show_unindexed = true,
      devicons_disabled = true,
      ignore_patterns = { "*.git/*", "*/tmp/*" },
      workspaces = {
        ["nvim"] = "/home/kiteboy/personalConfig/nvim",
      },
    },
  },
}

telescope.load_extension "fzf" -- Sorter using fzf algorithm
telescope.load_extension "frecency" -- Frecency algorithm
telescope.load_extension "cheat"
-- telescope.load_extension "ui-select" -- vim.ui.select

-- toggle telescope.nvim
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<CR>", {
  -- callback = require("telescope.builtin").find_files,
  -- desc = "Fuzzy find files using Telescope",
  noremap = true,
  silent = true,
})

map(
  "n",
  "<Leader>ps",
  [[<cmd>lua require("telescope.builtin").grep_string { path_display = { "shorten" }, search = vim.fn.input "Grep String > ", only_sort_text = true, use_regex = true }<CR>]],
  {
    -- callback = M.grep_prompt,
    -- desc = "Fuzzy grep files using Telescope",
    noremap = true,
    silent = true,
  }
)

map(
  "n",
  "<Leader>pw",
  [[<cmd>lua require("telescope.builtin").grep_string { path_display = { "shorten" }, search = vim.fn.expand("<cword>") }<CR>]],
  {
    -- callback = M.grep_prompt,
    -- desc = "Fuzzy grep files using Telescope",
    noremap = true,
    silent = true,
  }
)

map(
  "n",
  "<leader>ph",
  [[<cmd>lua require('telescope.builtin').help_tags()<cr>]],
  { noremap = true, silent = true }
)

map(
  "n",
  "<leader>pb",
  [[<cmd>lua require('telescope.builtin').buffers({sort_lastused = true})<CR>]],
  { noremap = true, silent = true }
)

map("n", "<Leader>ft", [[<cmd>lua require("telescope.builtin").builtin()<CR>]], {
  -- callback = M.builtins,
  -- desc = "Fuzzy grep files using Telescope",
  noremap = true,
  silent = true,
})

map(
  "n",
  "<Leader>ff",
  [[<cmd>lua require('telescope').extensions.frecency.frecency()<CR>]],
  {
    -- callback = M.frecency,
    -- desc = "File picker using frecency algorithm",
    noremap = true,
    silent = true,
  }
)

map(
  "n",
  "<Leader>fb",
  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
  {
    -- callback = require("telescope.builtin").current_buffer_fuzzy_find,
    -- desc = "Fuzzy grep current buffer content using Telescope",
    noremap = true,
    silent = true,
  }
)

map(
  "n",
  "<C-y>",
  "<cmd>lua require('telescope.builtin').resume()<CR>",
  {
    -- callback = require("telescope.builtin").current_buffer_fuzzy_find,
    -- desc = "Fuzzy grep current buffer content using Telescope",
    noremap = true,
    silent = true,
  }
)

map(
  "n",
  "<Leader>wo",
  [[<cmd>lua require("telescope.builtin").lsp_document_symbols { path_display = { "absolute" } }<CR>]],
  {
    -- callback = require("telescope.builtin").current_buffer_fuzzy_find,
    -- desc = "Fuzzy grep current buffer content using Telescope",
    noremap = true,
    silent = true,
  }
)
