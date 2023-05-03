-- vim.cmd [[set fcs=eob:\ ]]
-- vim.cmd [[filetype plugin indent on]]

local options = {
    termguicolors = true,
    fileencoding = "utf-8",
    guifont = "SFMono Nerd Font Mono:h12",
    autoread = true,
    wrap = true,
    backup = false,
    swapfile = false,
    hlsearch = false,
    incsearch = true,
    showmode = false,
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
    softtabstop = 2,
    scrolloff = 5,
    autoindent = true,
    smartindent = true,
    sidescrolloff = 5,
    signcolumn = "yes",
    hidden = true,
    ignorecase = true,
    timeoutlen = 0,
    shiftround = true,
    smartcase = true,
    splitbelow = true,
    splitright = true,
    number = true,
    relativenumber = true,
    clipboard = "unnamedplus",
    cursorline = true,
    mouse = "a",
    cmdheight = 1,
    undodir = "/tmp/.nvimdid",
    undofile = true,
    pumheight = 10,
    laststatus = 3,
    updatetime = 250,
    background = "dark",
    -- foldmethod = "expr",
    -- foldexpr = "nvim_treesitter#foldexpr()",
}

local globals = {
  neovide_cursor_animation_length = 0.02,
  neovide_cursor_vfx_mode = "torpedo",
  neovide_cursor_vfx_opacity = 150,
  neovide_cursor_vfx_particle_lifetime = 1,
}

vim.opt.shortmess:append "c"

for key, value in pairs(options) do
  vim.opt[key] = value
end

for key, value in pairs(globals) do
  vim.g[key] = value
end

-- utils.setIndentSize { go = 4, python = 4, rust = 4, cpp = 4, c = 4, make = 4, lua = 4 }

--require("theme").load_theme()

