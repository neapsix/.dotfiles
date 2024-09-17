--
-- plugins/init.lua - Plugins for Neovim
--

-- Install paq if it's not installed
local paq = require("plugins.bootstrap_paq").bootstrap_paq()

-- Install plugins
paq:setup { verbose = false } {
    "savq/paq-nvim",

    -- Basic editor features
    -- Note: Prefer this plugin to mini.pairs for integration with cmp
    "windwp/nvim-autopairs",
    -- Note: Prefer this plugin to built-in commenting and mini.comment
    -- for block comments and horizontal motions, e.g. gc$.
    "numToStr/Comment.nvim",

    "echasnovski/mini.nvim",

    -- Syntax features
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "windwp/nvim-ts-autotag",
    "abecodes/tabout.nvim",

    -- LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-lint",
    "stevearc/conform.nvim",
    "folke/trouble.nvim",

    -- DAP
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",

    -- Language-specific debugger setup
    "leoluz/nvim-dap-go",

    -- Completion
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-calc",
    "hrsh7th/nvim-cmp",

    -- Snippets
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",

    -- UI features
    "linrongbin16/lsp-progress.nvim",
    -- Note: Tried mini.statusline but prefer lualine
    "nvim-lualine/lualine.nvim",
    -- "nvim-tree/nvim-tree.lua",
    -- 'ellisonleao/glow.nvim';
    "neapsix/glow.nvim", -- Use my patched version of glow.nvim
    -- "mfussenegger/nvim-fzy",
    -- "mfussenegger/nvim-qwahl",

    -- Color schemes
    -- "shaunsingh/nord.nvim";
    "rose-pine/neovim",
    -- "catppuccin/nvim",
    -- "folke/tokyonight.nvim",
    -- "nyoom-engineering/oxocarbon.nvim",
}

-- The user has to run :PaqInstall or :PaqSync once to pull everything

require("rose-pine").setup {
    highlight_groups = {
        Comment = { fg = "muted" },
    },
}

-- require("catppuccin").setup {
--     flavour = "macchiato",
-- }

-- require("tokyonight").setup {
--     style = "storm",
-- }

-- Select a color scheme
-- Note: Do this before setting up plugins that need to be themed
-- vim.cmd [[colorscheme nord]]
vim.cmd [[colorscheme rose-pine]]
-- vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[colorscheme tokyonight]]
-- vim.cmd [[colorscheme oxocarbon]]

-- Run after-install setup for plugins that need it
require("nvim-autopairs").setup {}
-- Make sure nothing remaps <CR> after this.
-- require("mini.pairs").setup {}
-- Make sure nothing remaps <CR> after this.
require("Comment").setup {}
require("mini.ai").setup {}
-- require("mini.bracketed").setup {} -- Replaces next/prev buffer with [b ]b
require "plugins.config.mini.bufremove"
require "plugins.config.mini.clue"
-- Load mini.completion after mini.pairs
-- require "plugins.config.mini.completion"
require "plugins.config.mini.diff"
require "plugins.config.mini.files"
require "plugins.config.mini.hipatterns"
require("mini.icons").setup {} -- Works as drop-in for nvim-web-devicons
require "plugins.config.mini.map"
require "plugins.config.mini.pick"
require "plugins.config.mini.sessions"
require("mini.splitjoin").setup {}
require("mini.surround").setup {}

require "plugins.config.nvim-treesitter"
require("nvim-ts-autotag").setup {}

require("mason").setup {}
require("mason-lspconfig").setup {}
require "plugins.config.nvim-lint"
require "plugins.config.conform"
require "plugins.config.nvim-lspconfig"
require "plugins.config.luasnip"
require "plugins.config.trouble"

require "plugins.config.nvim-cmp"
-- If a completion plugin uses the tab key, load tabout after.
require("tabout").setup {}

require "plugins.config.nvim-dap"
require "plugins.config.nvim-dap-ui"

require("dap-go").setup {}

require "plugins.config.lsp-progress"
-- Load lualine after lsp-progress
require "plugins.config.lualine"
-- require "plugins.config.nvim-tree"
vim.g.glow_no_install = true -- Config for patched glow.nvim
-- require "plugins.config.nvim-fzy"
-- require "plugins.config.nvim-qwahl"
