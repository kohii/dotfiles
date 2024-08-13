-- Note: default plugins are listed here:
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/plugins/init.lua
return {
  {
    "NvChad/base46",
    enabled = not vim.g.vscode,
  },
  {
    "NvChad/ui",
    enabled = not vim.g.vscode,
  },
  {
    "nvim-tree/nvim-web-devicons",
    enabled = not vim.g.vscode,
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = not vim.g.vscode,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = not vim.g.vscode,
  },
  {
    "folke/which-key.nvim",
    enabled = not vim.g.vscode,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
    enabled = not vim.g.vscode,
  },
  {
    "williamboman/mason.nvim",
    enabled = not vim.g.vscode,
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = not vim.g.vscode,
  },
  {
    "windwp/nvim-autopairs",
    enabled = not vim.g.vscode,
  },
  {
    "NvChad/nvim-colorizer.lua",
    enabled = not vim.g.vscode,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = not vim.g.vscode,
  },

  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("nvchad.configs.lspconfig").defaults()
  --     require "configs.lspconfig"
  --   end,
  -- },
  --
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
