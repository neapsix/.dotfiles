--
-- ~/.config/nvim/init.lua
--      Main neovim configuration file
--
vim.loader.enable()

require "core.options"
require "core.mappings"
require "core.autocmds"
require "plugins"
