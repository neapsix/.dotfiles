--
-- plugins/config/nvim-fzy.lua - config for nvim-fzy plugin
--
--  This configuration requires fzy, fd, git, and ag to be available.

local fzy = require "fzy"

local function open_file()
    fzy.execute("fd", fzy.sinks.edit_file)
end

local function open_file_from_git()
    fzy.execute("git ls-files", fzy.sinks.edit_file)
end

local function edit_live_grep()
    fzy.execute("ag --nobreak --noheading .", fzy.sinks.edit_live_grep)
end

vim.keymap.set("n", "<leader>ff", open_file)
vim.keymap.set("n", "<leader>fg", open_file_from_git)
vim.keymap.set("n", "<leader>fl", edit_live_grep)
