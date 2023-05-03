local M = {
  setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig["emmet_ls"].setup {
      filetypes = {"html", "typescriptreact", "javascriptreact", "css", "scss", "sass", "less"},
    }
  end
}

return M
