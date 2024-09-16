--
-- plugins/config/mini/bufremove.lua - config for mini.bufremove plugin
--

require("mini.bufremove").setup {}

-- Note: use ZQ or :bd command to close buffer AND window.
vim.keymap.set("n", "<leader>bd", MiniBufremove.delete, { desc = "Buffer delete (mini.bufremove)" })
vim.keymap.set("n", "<leader>bu", MiniBufremove.unshow, { desc = "Buffer unshow (mini.bufremove)" })
