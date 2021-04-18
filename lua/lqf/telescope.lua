local previewers = require('telescope.previewers')

local _bad = { '.*%.min' } -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
        print(v)
      return false
    end
  end

  return true
end

local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 100000 then
            print('heoo')
            return
        else
            if opts.use_ft_detect == nil then opts.use_ft_detect = true end
            opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end
require'telescope'.setup {
    defaults = {
        -- file_sorter = require('telescope.sorters').get_fzy_sorter,
        -- generic_sorter = require('telescope.sorters').get_fzy_sorter,
        buffer_previewer_maker = new_maker,
    }
}

-- require('telescope').load_extension('fzy_native')
