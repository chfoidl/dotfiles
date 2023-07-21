local M = {}

local settings = {
  intelephense = {
    format = {
      enable = false,
    },
    environment = {
      documentRoot = "core/index.php",
      includePaths = {
        "web/core/includes",
      },
      phpdoc = {
        returnVoid = false,
      },
    },
    files = {
      maxSize = 5000000,
    },
  },
}

M.setup = function(on_attach, capabilities)
  local lspconfig = require "lspconfig"

  lspconfig.intelephense.setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
    settings = settings,
    capabilities = capabilities,
    init_options = {
      licenceKey = "--------",
    },
  }
end

return M
