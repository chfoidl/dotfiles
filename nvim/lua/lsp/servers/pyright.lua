local M = {}

M.setup = function(on_attach, capabilities)
  local lspconfig = require "lspconfig"

  lspconfig.pyright.setup {
  }
end

return M
