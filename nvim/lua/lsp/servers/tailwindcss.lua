local M = {
  setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig["tailwindcss"].setup {

    }
  end
}

return M
