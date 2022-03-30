--
-- plugins/config/trouble.lua - config for trouble.nvim plugin
--

require 'trouble'.setup {
    icons = false,
}

local options = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<Leader>xx', '<cmd>TroubleToggle<cr>', options)
vim.api.nvim_set_keymap('n', '<Leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', options)
vim.api.nvim_set_keymap('n', '<Leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', options)
vim.api.nvim_set_keymap('n', '<Leader>xq', '<cmd>TroubleToggle quickfix<cr>', options)
vim.api.nvim_set_keymap('n', '<Leader>xl', '<cmd>TroubleToggle loclist<cr>', options)
vim.api.nvim_set_keymap('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', options)
