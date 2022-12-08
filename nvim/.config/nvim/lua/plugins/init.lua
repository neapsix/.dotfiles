--
-- plugins.lua - Plugins for Neovim
--

-- Install paq if it's not installed
local paq = require 'plugins.bootstrap_paq'.bootstrap_paq {}

-- Install plugins
paq:setup({verbose=false}) {
    'savq/paq-nvim';

    -- Libraries
    'nvim-lua/plenary.nvim';

    -- Basic editor features
    'windwp/nvim-autopairs';
    'numToStr/Comment.nvim';

    -- Markdown
    -- 'godlygeek/tabular';
    -- 'preservim/vim-markdown';

    -- Syntax features
    {'nvim-treesitter/nvim-treesitter', run='TSUpdate'};
    'abecodes/tabout.nvim';
    'norcalli/nvim-colorizer.lua';

    -- LSP
    'williamboman/mason.nvim';
    'williamboman/mason-lspconfig.nvim';
    'jose-elias-alvarez/null-ls.nvim';
    'neovim/nvim-lspconfig';
    'L3MON4D3/LuaSnip';
    'folke/trouble.nvim';
    'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim';

    -- Completion
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-nvim-lsp-signature-help';
    'saadparwaiz1/cmp_luasnip';
    'hrsh7th/cmp-buffer';
    'hrsh7th/cmp-path';
    'hrsh7th/cmp-cmdline';
    'hrsh7th/cmp-calc';
    'hrsh7th/nvim-cmp';

    -- Snippets
    'rafamadriz/friendly-snippets';

    -- Git integration
    'lewis6991/gitsigns.nvim';

    -- UI features
    'nvim-lualine/lualine.nvim';
    -- 'ellisonleao/glow.nvim';
    'neapsix/glow.nvim';   -- Use my patched version of glow.nvim
    'nvim-telescope/telescope.nvim';
    {'nvim-telescope/telescope-fzf-native.nvim', run='make'};
    'nvim-telescope/telescope-file-browser.nvim';

    -- Color schemes
    -- 'atelierbram/Base2Tone-vim';
    -- 'sainnhe/everforest';
    -- 'shaunsingh/nord.nvim';
    -- 'bluz71/vim-nightfly-guicolors';
    -- 'rafamadriz/neon';
    'rose-pine/neovim';
}

-- The user has to run :PaqInstall or :PaqSync once to pull everything

-- Select a color scheme
-- Note: Do this before setting up plugins that need to be themed
-- vim.cmd[[colorscheme Base2Tone_EveningDark]]
-- vim.cmd[[colorscheme everforest]]
-- vim.cmd[[colorscheme nord]]
-- vim.cmd[[colorscheme nightfly]]
-- vim.cmd[[colorscheme neon]]
vim.cmd[[colorscheme rose-pine]]

-- Run after-install setup for plugins that need it
require 'nvim-autopairs'.setup {}
require 'Comment'.setup {}

-- vim.g.vim_markdown_folding_level = 3
-- vim.g.vim_markdown_new_list_item_indent = 2

require 'plugins.config.nvim-treesitter'
require 'tabout'.setup {}
require 'colorizer'.setup {}

require("mason").setup()
require("mason-lspconfig").setup()
require 'plugins.config.null-ls'
require 'plugins.config.nvim-lspconfig'
require("luasnip.loaders.from_vscode").lazy_load()
require 'plugins.config.trouble'
require 'plugins.config.toggle-lsp-diagnostics'

require 'plugins.config.nvim-cmp'

require 'gitsigns'.setup {}

require 'plugins.config.lualine'
vim.g.glow_no_install = true    -- Config for patched glow.nvim
require 'plugins.config.telescope'
