--
-- plugins/config/nvim-dap.lua - config for nvim-dap plugin
--
local dap = require "dap"

-- Note: Go debugging with Delve is set up using gopher.nvim plugin.

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dt", dap.terminate)
