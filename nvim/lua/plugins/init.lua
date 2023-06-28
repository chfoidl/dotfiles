local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})

	print("Installing lazy plugin manager! Close and reopen neovim...")
end

-- @todo cleanup
vim.opt.rtp:prepend(lazypath)
vim.g.codeium_disable_bindings = 1
vim.g.copilot_no_maps = 1
vim.g.copilot_no_tab_map = 1
vim.g.copilot_assume_mapped = true
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- Define diagnostic icons
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- Use protected call to make sure lazy actually exists.
local ok, lazy = pcall(require, "lazy")
if not ok then
	return
end

-- Lazy config options
local opts = {
	ui = {
		border = "rounded",
	},
}

-- Setup Lazy
lazy.setup({
	-- UI
	{
		"chfoidl/base46",
		config = function()
			local theme = require("base46")
			theme.load_theme()

			theme.load_highlight("neotree")
			theme.load_highlight("cmp")
			theme.load_highlight("devicons")
			theme.load_highlight("git")
			theme.load_highlight("lsp")
			theme.load_highlight("notify")
			theme.load_highlight("telescope")
			theme.load_highlight("treesitter")
			theme.load_highlight("whichkey")
			theme.load_highlight("mason")
			theme.load_highlight("lazy")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000, -- Ensure it loads first
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Ensure it loads first
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("plugins.config.web-devicons")
		end,
	},
	"folke/which-key.nvim",
	{
		"folke/twilight.nvim",
		opts = {
			expand = {
				"function",
				"method",
			},
		},
		cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
	},
	{
		"folke/zen-mode.nvim",
		dependencies = {
			"folke/twilight.nvim",
		},
		opts = {},
		cmd = "ZenMode",
	},

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("plugins.config.dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		-- Commit before change of use_custom_captures
		--commit = "4cccb6f494eb255b32a290d37c35ca12584c74d0",
		build = ":TSUpdate",
		config = function()
			require("plugins.config.treesitter")
		end,
	},
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-tree-docs",

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.config.telescope")
		end,
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},

	-- Navigation
	{
		"kwkarlwang/bufjump.nvim",
		config = function()
			require("bufjump").setup()
		end,
	},

	-- Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		opts = {
			close_if_last_window = true,
			window = {
				mappings = {
					["o"] = "open",
				},
			},
		},
	},

	-- Assistance
	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.config.autopairs")
		end,
	},

	-- LSP
	"ray-x/lsp_signature.nvim",
	{
		"j-hui/fidget.nvim",
		config = function()
			require("plugins.config.fidget")
		end,
	},

	-- Codeium
	-- {
	-- 	"jcdickinson/codeium.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		"hrsh7th/nvim-cmp",
	-- 	},
	--    config = function()
	--      require("codeium").setup({})
	--    end
	-- },
	-- {
	-- 	"Exafunction/codeium.vim",
	-- 	config = function()
	-- 		vim.keymap.set("i", "<M-CR>", function()
	-- 			return vim.fn["codeium#Accept"]()
	-- 		end, { expr = true })
	-- 		vim.keymap.set("i", "<M-n>", function()
	-- 			return vim.fn["codeium#CycleCompletions"](1)
	-- 		end, { expr = true })
	-- 		vim.keymap.set("i", "<M-p>", function()
	-- 			return vim.fn["codeium#CycleCompletions"](-1)
	-- 		end, { expr = true })
	-- 		vim.keymap.set("i", "<M-c>", function()
	-- 			return vim.fn["codeium#Clear"]()
	-- 		end, { expr = true })
	-- 	end,
	-- },

	-- Intellisense
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"rcarriga/cmp-dap",
		},
		config = function()
			require("plugins.config.cmp")
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("plugins.config.luasnip")
		end,
	},

	-- Installers
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"typescript-language-server",
				"intelephense",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			"williamboman/mason.nvim",
		},
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},
	{
		"jose-elias-alvarez/typescript.nvim",
	},

	-- Markdown
	{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
	},

	-- Mini
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.comment").setup()
		end,
	},

  -- Copilot
  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     vim.keymap.set("i", "<M-CR>", function () return vim.fn['copilot#Accept']() end, { expr = true })
  --     vim.keymap.set('i', '<M-g>', function() return vim.fn['copilot#Suggest']() end, { expr = true, silent = true })
  --     vim.keymap.set('i', '<M-n>', function() return vim.fn['copilot#Next']() end, { expr = true })
  --     vim.keymap.set('i', '<M-p>', function() return vim.fn['copilot#Previous']() end, { expr = true })
  --     vim.keymap.set('i', '<M-c>', function() return vim.fn['copilot#Dismiss']() end, { expr = true })
  --   end
  -- }
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = false,
        keymap = {
          accept = "<M-CR>",
          next = "<M-n>",
          prev = "<M-p>",
        }
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        layout = {
          position = "bottom",
          ration = 0.4,
        },
        keymap = {
          open = "<M-o>",
          accept = "<CR>",
          jump_next = "n",
          jump_prev = "p",
          refresh = "gr",
        }
      }
    }
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "zbirenbaum/copilot.lua",
    },
    config = function()
      require("copilot_cmp").setup()
    end,
  }

	-- Copilot
	--[[
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.keymap.set("i", "<M-CR>", function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<M-n>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<M-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<M-c>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-CR>",
          next = "<M-n>",
          prev = "<M-p>",
          dismis = "<M-h>",
        },
      },
    }
  }
  --]]
}, opts)
