-- 
-- plugins.lua - Plugins for Neovim
--

-- Install plugins
require "paq" {
    "savq/paq-nvim";
    "numToStr/Comment.nvim";
    "atelierbram/Base2Tone-vim";
    -- "shaunsingh/nord.nvim";
    -- "bluz71/vim-nightfly-guicolors";
    -- "rafamadriz/neon";
}

-- Run after-install setup for plugins that need it
require 'Comment'.setup {}

-- Select a color scheme
vim.cmd[[colorscheme Base2Tone_EveningDark]]
-- vim.cmd[[colorscheme nord]]
-- vim.cmd [[colorscheme nightfly]]
-- vim.cmd[[colorscheme neon]]
