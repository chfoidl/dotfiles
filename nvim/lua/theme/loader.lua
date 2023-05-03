local merge_tb = require("theme").merge_tb

local highlights = {}
local integrations = {
  "bufferline",
  "cmp",
  "devicons",
  "feline",
  "git",
  "mail",
  "misc",
  "nvchad",
  "nvimtree",
  "syntax",
  "telescope",
  "treesitter",
  "statusline",
  "tabby",
  "neo-tree",
}

-- Load integrations
for _, name in ipairs(integrations) do
  local ok, integration = pcall(require, "theme.integrations." .. name)
  if ok then
    highlights = merge_tb(highlights, integration)
  end
end

-- polish theme specific highlights
local polish_hl = require("theme").get_colors "polish_hl"
if polish_hl then
   highlights = merge_tb(highlights, polish_hl)
end

-- finally set all highlights :D
for hl, col in pairs(highlights) do
   vim.api.nvim_set_hl(0, hl, col)
end
