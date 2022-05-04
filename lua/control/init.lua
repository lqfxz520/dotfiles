local plugin = require('control.plugin')
local wk = require('which-key')
local lsp = require('control.lsp')

---@class CrowsModule
---@field key table
---@field modules string[]
---@field features Feature[]

---@type CrowsModule
local control = {
  modules = {},
  features = {},
}

---@class CrowsOption
---@field modules string[]
---@field features Feature[]

---@class Feature
---@field pre? function config not depend on plugin
---@field plugins? PluginSpec[]
---@field post? function config depend on plugin
local default_plugin = {
  { 'wbthomason/packer.nvim', opt = true },
  'folke/which-key.nvim',
  'nvim-lua/plenary.nvim',
  'neovim/nvim-lspconfig',
}

local function load_plugins()
  for _, plug in ipairs(default_plugin) do
    plugin.use(plug)
  end
  for _, feature in ipairs(control.features) do
    if feature.plugins ~= nil then
      for _, plug in ipairs(feature.plugins) do
        plugin.use(plug)
      end
    end
  end
end

---setup crows
---@param opt CrowsOption
function control.setup(opt)
  vim.api.nvim_create_user_command('ControlReload', control.reload, {})
  vim.api.nvim_create_user_command('ControlResync', control.resync, {})
  vim.api.nvim_create_user_command('ControlUpdateSync', control.external_resync, {})
  control.modules = opt.modules or {}
  control.features = opt.features or {}
  for _, feature in ipairs(control.features) do
    if feature.pre ~= nil then
      feature.pre()
    end
  end
  if plugin.is_ready() then
    control.post_setup()
  else
    load_plugins()
    plugin.init(control.post_setup)
  end
end

function control.post_setup()
  for _, feature in ipairs(control.features) do
    if feature.post ~= nil then
      local ok, err = pcall(feature.post)
      if not ok then
        vim.notify(err, 'warn')
      end
    end
  end
end

local function reset()
  for _, m in ipairs(control.modules) do
    require('plenary.reload').reload_module(m)
  end
  plugin.reset()
  wk.reset()
  lsp.stop_all_clients()
  vim.cmd('runtime! init.lua')
  load_plugins()
end

function control.reload()
  reset()
  plugin.compile()
end

function control.resync()
  reset()
  plugin.sync()
end

function control.external_resync()
  plugin.sync_and_quit()
end

function control.print(v)
  print(vim.inspect(v))
  return v
end

return control
