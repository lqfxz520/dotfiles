---@type Feature[]
local features = {
  require('features.basic'),
  require('features.color_hint'),
  require('features.file_explorer'),
  require('features.completion'),
  require('features.editor'),
  require('features.search'),
  -- statusline and tabline require themes
  require('features.theme'),
  require('features.tabline'),
  require('features.statusline'),
  require('features.lsp'),
}

for _, lang in ipairs(require('features.languages')) do
  table.insert(features, lang)
end
-- format requires languages
table.insert(features, require('features.format'))

return features
