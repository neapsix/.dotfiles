--
-- plugins/config/nvim-dap.lua - config for nvim-dap plugin
--
local dap = require "dap"

-- Note: Go debugging with Delve is set up using gopher.nvim plugin.

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP continue" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "DAP terminate" })
