local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

treesitter.setup {
  autotag = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    "lua",
    "javascript",
    "typescript",
    "php",
    "json",
    "yaml",
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    queries = {
      php = {
        "~/.config/nvim/after/queries/php/highlights.scm"
      }
    },
  },
  --[[
  highlight = {
    enable = true,
    queries = {
      php = {
        "~/.config/nvim/after/queries/php/highlights.scm"
      }
    },
  },
  --]]
  --[[
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  --]]
}

local custom_captures = {
  ["opening_tag"] = "TSOpeningTag",
  ["fullvariable"] = "TSVariable",
  ["use.fqdn"] = "Text",
  ["use.name"] = "TSType",
  ["method.constructor"] = "TSMethodConstructor",
  ["comment.tag"] = "TSKeyword",
  ["comment.type"] = "TSType",
  ["comment.inline.tag"] = "TSKeyword",
  ["ref.self"] = "TSType",
  ["operator.method"] = "TSText",
  ["import.identifier"] = "TSProperty",
}

for capture, hlgroup in pairs(custom_captures) do
  vim.api.nvim_set_hl(0, "@" .. capture, { link = hlgroup, default = true })
end


local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.twig = {
  install_info = {
    url = "https://github.com/eirabben/tree-sitter-twig",
    files = {"src/parser.c", "src/scanner.cc"},
    branch = "main",
  },
  filetype = "twig",
}
