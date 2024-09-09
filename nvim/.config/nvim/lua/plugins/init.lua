--
-- plugins.lua - Plugins for Neovim
--

-- Install paq if it's not installed
local paq = require("plugins.bootstrap_paq").bootstrap_paq()

-- Install plugins
paq:setup { verbose = false } {
    "savq/paq-nvim",

    -- Libraries
    "nvim-lua/plenary.nvim",

    -- Basic editor features
    "windwp/nvim-autopairs",
    "numToStr/Comment.nvim",
    -- Note: editorconfig support is built in starting in neovim 0.9.
    -- 'gpanders/editorconfig.nvim',
    -- TODO: try okuuva/auto-save.nvim, fork of Pocco81/auto-save.nvim
    -- 'https://git.sr.ht/~nedia/auto-save.nvim',

    -- Syntax features
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "vrischmann/tree-sitter-templ",
    "abecodes/tabout.nvim",
    "norcalli/nvim-colorizer.lua",

    -- LSP
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-lint",
    "stevearc/conform.nvim",
    "L3MON4D3/LuaSnip",
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
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-calc",
    "hrsh7th/nvim-cmp",

    -- Snippets
    "rafamadriz/friendly-snippets",

    -- Git integration
    "lewis6991/gitsigns.nvim",

    -- UI features
    "nvim-lualine/lualine.nvim",
    "nvim-tree/nvim-web-devicons", -- Req. for barbar, opt. for nvim-tree
    'romgrk/barbar.nvim';
    "nvim-tree/nvim-tree.lua",
    -- 'ellisonleao/glow.nvim';
    "neapsix/glow.nvim", -- Use my patched version of glow.nvim
    "mfussenegger/nvim-fzy",
    "mfussenegger/nvim-qwahl",

    -- Color schemes
    -- "shaunsingh/nord.nvim";
    -- "AlexvZyl/nordic.nvim",
    -- "rose-pine/neovim",
    -- "catppuccin/nvim",
    -- "folke/tokyonight.nvim",
    "nyoom-engineering/oxocarbon.nvim",
}

-- The user has to run :PaqInstall or :PaqSync once to pull everything

-- require("rose-pine").setup {
--     dark_variant = "moon",
-- }

-- require("catppuccin").setup {
--     flavour = "frappe",
-- }

-- Select a color scheme
-- Note: Do this before setting up plugins that need to be themed
-- vim.cmd[[colorscheme nord]]
-- vim.cmd [[colorscheme nordic]]
-- vim.cmd [[colorscheme rose-pine]]
-- vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[colorscheme tokyonight]]
vim.cmd [[colorscheme oxocarbon]]

-- Run after-install setup for plugins that need it
require("nvim-autopairs").setup {}
require("Comment").setup {}
-- Note: the simple auto-save plugin has an exclude_ft option to turn off auto-
-- save for specified file types, but I would prefer an include_ft option to
-- auto-save ONLY for certain types (e.g. markdown).
-- require 'auto-save'.setup { silent = false }

require "plugins.config.nvim-treesitter"
require("colorizer").setup {}

require("mason").setup {}
require("mason-lspconfig").setup {}
require "plugins.config.nvim-lint"
require "plugins.config.conform"
require "plugins.config.nvim-lspconfig"
require("luasnip.loaders.from_vscode").lazy_load {}
require "plugins.config.trouble"

require "plugins.config.nvim-cmp"
-- If a completion plugin is using tabs, load tabout after.
require("tabout").setup {}

require "plugins.config.nvim-dap"
require "plugins.config.nvim-dap-ui"

require("dap-go").setup {}

require("gitsigns").setup {}

require "plugins.config.lualine"
-- Alternative to managing buffers and files with fzy:
require "plugins.config.barbar"
require "plugins.config.nvim-tree"
vim.g.glow_no_install = true -- Config for patched glow.nvim
require "plugins.config.nvim-fzy"
require "plugins.config.nvim-qwahl"
