local tabby_config = function()
  local palette = require('features.theme').palette
  local filename = require('tabby.module.filename')
  local tabname = function(tabid)
    local number = vim.api.nvim_tabpage_get_number(tabid)
    local name = require('tabby.tab').get_name(tabid)
    return string.format('%d: %s', number, name)
  end
  local cwd = function()
    return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
  end
  local line = {
    hl = { fg = palette.fg, bg = palette.bg },
    layout = 'active_wins_at_tail',
    head = {
      { cwd, hl = { fg = palette.bg, bg = palette.accent, style = 'italic' } },
      { '', hl = { fg = palette.accent, bg = palette.bg } },
    },
    active_tab = {
      label = function(tabid)
        return {
          '  ' .. tabname(tabid) .. ' ',
          hl = { fg = palette.bg, bg = palette.accent_sec, style = 'bold' },
        }
      end,
      left_sep = { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
      right_sep = { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
    },
    inactive_tab = {
      label = function(tabid)
        return {
          '  ' .. tabname(tabid) .. ' ',
          hl = { fg = palette.fg, bg = palette.bg_sec, style = 'bold' },
        }
      end,
      left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
      right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
    },
    top_win = {
      label = function(winid)
        return {
          '  ' .. filename.unique(winid) .. ' ',
          hl = { fg = palette.fg, bg = palette.bg_sec },
        }
      end,
      left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
      right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
    },
    win = {
      label = function(winid)
        return {
          '  ' .. filename.unique(winid) .. ' ',
          hl = { fg = palette.fg, bg = palette.bg_sec },
        }
      end,
      left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
      right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
    },
    tail = {
      { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
      { '  ', hl = { fg = palette.bg, bg = palette.accent_sec } },
    },
  }
  require('tabby').setup({ tabline = line })
end

---@type Feature
local tabline = {}

tabline.plugins = {
  {
    'nanozuki/tabby.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = tabby_config,
  },
}

tabline.post = function()
  local wk = require("which-key")
  local gt = {}
  for i = 1, 6, 1 do
    gt["<A-" .. i .. ">"] = { i .. "gt", i .. "th gt" }
  end
  gt["<leader>t"] = {
    c = { ":$tabnew<CR>", "Create new tab" },
    x = { ":tabclose<CR>", "Close current tab" },
    o = { ":tabonly<CR>", "Close other tabs" },
    n = { ":tabn<CR>", "Go to next tab" },
    p = { ":tabp<CR>", "Go to previous tab" },
    m = {
      p = { ":-tabmove<CR>", "Move current tab to previous position" },
      n = { ":+tabmove<CR>", "Move current tab to next position " },
    },
  }
  wk.register(gt)
end

return tabline
