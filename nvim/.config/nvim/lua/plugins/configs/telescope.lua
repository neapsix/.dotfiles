--
-- plugins/configs/telescope.lua - config for telescope plugin
--

-- local telescope = require 'telescope'
-- local actions = require 'telescope.actions'

--[[ telescope.setup({
    mappings = {
        i = {
            -- ['<ESC>'] = actions.close,
            -- ['<C-h'] = "which_key",
        },
    },
}) ]]

require 'telescope'.load_extension 'fzf'
require 'telescope'.load_extension 'file_browser'

local options = { noremap = true, silent = true }
-- Builtins
vim.api.nvim_set_keymap('n', '<Leader>fa', '<cmd>lua require [[telescope.builtin]].builtin()<cr>', options)
vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>lua require [[telescope.builtin]].find_files()<cr>', options)
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>lua require [[telescope.builtin]].live_grep()<cr>', options)
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>lua require [[telescope.builtin]].buffers()<cr>', options)
vim.api.nvim_set_keymap('n', '<Leader>fh', '<cmd>lua require [[telescope.builtin]].help_tags()<cr>', options)
-- Extensions
vim.api.nvim_set_keymap('n', '<Leader>fl', '<cmd>Telescope file_browser<cr>', options)
