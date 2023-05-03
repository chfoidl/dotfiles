require "settings"
require "plugins"
require "lsp"
require "mappings"

--vim.cmd.colorscheme "tokyonight"

-- statusline
vim.opt.statusline = "%!v:lua.require'ui.statusline'.run()"
