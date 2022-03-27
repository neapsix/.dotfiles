-- 
-- plugins.lua - Plugins for Neovim
--

-- Install paq if it's not installed
local paq = require 'plugins.bootstrap_paq'.bootstrap_paq {}

-- Install plugins
paq:setup({verbose=false}) {
    'savq/paq-nvim';

    -- Basic editor features
    'windwp/nvim-autopairs';
    'numToStr/Comment.nvim';

    -- Syntax features
    {'nvim-treesitter/nvim-treesitter', run='TSUpdate'};
    'abecodes/tabout.nvim';

    -- Completion
    'hrsh7th/cmp-buffer';
    'hrsh7th/nvim-cmp';

    -- Git integration
    'lewis6991/gitsigns.nvim';

    -- UI features
    'nvim-lualine/lualine.nvim';
    -- 'ellisonleao/glow.nvim'; 
    'neapsix/glow.nvim';   -- Use my patched version of glow.nvim 

    -- Benchmarking for Neovim 
    'henriquehbr/nvim-startup.lua';
    
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

require 'plugins.configs.nvim-treesitter'
require 'tabout'.setup {}

require 'plugins.configs.nvim-cmp'

require 'gitsigns'.setup {}

require 'plugins.configs.lualine'
vim.g.glow_no_install = true    -- Config for patched glow.nvim

require 'nvim-startup'.setup {}
