-- Shorten function name
local keymap = vim.api.nvim_set_keymap

local opts = {
  noremap = true,
  silent = true,
}

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Debug Highlight
keymap("n", "<F2>", "", opts)

-- Move text up and down
--keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
--keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Debug
keymap("n", "<F2>", ":TSH<CR>", opts)
keymap("n", "<F3>", ":TSP<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
--keymap("v", "<A-j>", ":m .+1<CR>==", opts)
--keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
--keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
--keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Exit terminal mode --
keymap("t", "<C-z>", "<C-\\><C-n>", opts)

-- Debugging --
vim.keymap.set("n", "<F5>", function()
  require('dap').continue()
end, opts)

vim.keymap.set("n", "ddb", function()
  require('dap').toggle_breakpoint()
end, opts)

local widgets = require('dap.ui.widgets')
local sidebar = widgets.sidebar(widgets.scopes)
vim.keymap.set("n", 'dus', function()
  sidebar.open()
end, opts)

vim.keymap.set("n", 'duf', function()
  widgets.centered_float(widgets.scopes)
end, opts)

--
-- Which Key --
--

local ok, wk = pcall(require, "which-key")

if not ok then
    return
end

wk.setup({
  triggers = "auto"
})

local wk_opts = {
    mode = "n",
    prefix = "<leader>",
    silent = true,
    noremap = true,
    nowait = true,
}

wk.register({
    ["p"] = { "<cmd>bn<cr>", "[BUFFER] Go previous buffer" },
    ["n"] = { "<cmd>bp<cr>", "[BUFFER] Go next buffer" },
    ["q"] = { "<cmd>bd<cr>", "[BUFFER] Close current buffer" },

    --["e"] = { "<cmd>NvimTreeToggle<cr> <cmd>NvimTreeRefresh<cr>", "[NVIMTREE] Toggle" },
    ["e"] = { "<cmd>Neotree<cr>", "[Neo-Tree] Toggle" },
    ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },

    ["f"] = {
        name = "Telescope",
        f = { "<cmd>Telescope find_files<cr>", "Files" },
        g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        h = { "<cmd>Telescope help_tags<cr>", "Help" },
        m = { "<cmd>Telescope marks<cr>", "Marks" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
        p = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "Command Prompt" },
    },

    ["g"] = {
        name = "[GIT]",
        s = { "<cmd>Gitsigns toggle_signs<cr>", "[GIT] Toggle signs" },
        h = { "<cmd>Gitsigns preview_hunk<cr>", "[GIT] Preview hunk" },
        d = { "<cmd>Gitsigns diffthis<cr>", "[GIT] Diff" },
        n = { "<cmd>Gitsigns next_hunk<cr>", "[GIT] Next hunk" },
        p = { "<cmd>Gitsigns prev_hunk<cr>", "[GIT] Prev hunk" },
    },
}, wk_opts)
