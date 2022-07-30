require 'toggle_lsp_diagnostics'.init {}

local options = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<Leader>lsp', '<cmd>lua require [[toggle_lsp_diagnostics]].toggle_diagnostics()<cr>', options)
