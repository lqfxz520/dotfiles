---@type Feature[]
local features = {
  require('features.theme'),
  require('features.basic'),
  require('features.file_explorer'),
  require('features.completion'),
  require('features.editor'),
  require('features.search'),
  require('features.tabline'),
  require('features.statusline'),
  require('features.color_hint'),
  require('features.lsp'),
}

for _, lang in ipairs(require('features.languages')) do
  table.insert(features, lang)
end
-- format requires languages
table.insert(features, require('features.format'))

return features
